//
//  TimerView.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 19/07/23.
//

import SwiftUI

var seasonsToLongPause = 4

enum ClockState: Int {
    case working = 300
    case shortPause = 5
    case longPause = 7
}

struct TimerView: View {
    @State var clockState: ClockState = .working
    @State var currentTime = ClockState.working.rawValue {
        didSet {
            withAnimation(.linear(duration: 1)) {
                percentProgress = CGFloat(currentTime) / CGFloat(clockState.rawValue)
            }
        }
    }
    @State var percentProgress: CGFloat = 1
    @State var timerIsActive = false
    @State var season = 0
    @State var timer: Timer?
    
    
    func startTimer() {
        withAnimation {
            timerIsActive = true
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.timer = timer
                currentTime -= 1
                if currentTime == -1 {
                    timerIsActive = false
                    timer.invalidate()
                    
                    if clockState == .working && season < seasonsToLongPause - 1 {
                        clockState = .shortPause
                    } else if clockState == .working {
                        clockState = .longPause
                    } else {
                        season = season == seasonsToLongPause - 1 ? 0 : season + 1
                        clockState = .working
                    }
                    currentTime = clockState.rawValue
                }
            }
        }
    }
    
    func pauseTimer() {
        timerIsActive = false
        timer?.invalidate()
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ///Header
                Text("All-In Timer")
                    .foregroundColor(Color.white)
                    .font(Font.custom("AvenirNextLTPro-Bold", size: 22))
                    .padding(.bottom, 36)
                
                /// Task
                TaskInput()
                    .padding(.bottom, 64)
                /// Count
                ZStack {
                    ///Blur circle
                    Circle()
//                        .trim(from: 0, to: percentProgress)
                        .stroke(Color.purpleLight.opacity(0.05), lineWidth: 120)
                        .frame(width: proxy.size.width - 200)
                        .rotationEffect(.degrees(-90))
                    Circle()
                        .trim(from: 0, to: percentProgress)
                        .stroke(Color.purpleLight.opacity(0.1), lineWidth: 120)
                        .frame(width: proxy.size.width - 200)
                        .rotationEffect(.degrees(-90))
                        
                    ///Middle Circle
                    Circle()
                        .fill(Color.purpleDark)
                        .shadow(color: .blueMain.opacity(0.4), radius: 16)
                        .frame(width: proxy.size.width - 160)
                        .overlay {
                            Text(currentTime.toTimeString())
                                .foregroundColor(Color.white.opacity(0.8))
                                .font(Font.custom("AvenirNextLTPro-Regular", size: 64))
                        }
                    /// Stroke circle
                    Circle()
                        .trim(from: 0, to: percentProgress)
                        .stroke(LinearGradient(colors: [Color.blueMain, Color.purpleLight], startPoint: .leading, endPoint: .trailing), lineWidth: 10)
                        .frame(width: proxy.size.width - 160)
                        .rotationEffect(.degrees(-90))
                    
                    ///Knob circle
                    VStack {
                        Circle()
                            .fill(Color.blueMain)
                            .frame(width: 32)
                            .shadow(radius: 12)
                            .overlay {
                                Circle()
                                    .fill(Color.white)
                                    .padding(6)
                            }
                            .offset(y: -(proxy.size.width - 160) / 2)
                        }
                        .frame(width: proxy.size.width - 100, height: proxy.size.width - 100)
                    .rotationEffect(.degrees(percentProgress * 360))

                }
                .padding(.bottom, 48)
                
                ProgressCircle(season: season)
                
                Button {
                    timerIsActive ? pauseTimer() : startTimer()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.blueMain.opacity(0.3))
                            .blur(radius: 12)
                        Circle()
                            .fill(Color.blueMain)
                            .frame(width: 80)
                        Image(systemName: timerIsActive ? "pause" : "play")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                        
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .padding()
            .background(Color.purpleDark)
        }
    }
}

struct ProgressCircle: View {
    var season: Int
    
    let onCircle: some View = Circle()
        .fill(Color.purpleLight)
        .frame(width: 16)
    
    let activeCircle: some View = Circle()
        .fill(Color.purpleLight)
        .frame(width: 24)
        .overlay {
            Circle()
                .fill(Color.purpleDark)
                .frame(width: 14)
        }
    
    let offCircle: some View = Circle()
        .fill(Color.gray)
        .frame(width: 16)
    
    struct PositionCircle: View {
        let index: Int
        let season: Int
        
        var body: some View {
            if index == season {
                ProgressCircle(season: season).activeCircle
            } else if index < season {
                ProgressCircle(season: season).onCircle
            } else {
                ProgressCircle(season: season).offCircle
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 120, height: 1)
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(Color.purpleLight)
                        .frame(width: CGFloat((120.0 / 3) * Float(season)), height: 1)
                }
            HStack {
                PositionCircle(index: 0, season: season)
                ForEach(1..<4) { index in
                    Spacer()
                    PositionCircle(index: index, season: season)
                }
            }
        }
        .frame(width: 120)
        .padding(.bottom, 36)
    }
}

struct TaskInput: View {
    var body: some View {
        Button {
            print("say hi!")
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 36)
                    .fill(Color.purpleLight)
                    .frame(height: 72)
                HStack {
                    Text("Task: Write an article")
                        .foregroundColor(Color.white)
                        .font(Font.custom("AvenirNextLTPro-Light", size: 22))
                    Spacer()
                    Image(systemName: "pencil.line")
                        .font(.system(size: 22))
                }.foregroundColor(Color.white)
                    .padding(.horizontal)
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 14 Pro Max")
    }
}
