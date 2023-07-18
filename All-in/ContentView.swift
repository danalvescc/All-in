//
//  ContentView.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 14/07/23.
//

import SwiftUI

var endTime = 4

struct ContentView: View {
    @State var currentTime = endTime {
        didSet {
            withAnimation(.linear) {
                percentProgress = CGFloat(currentTime) / CGFloat(endTime)
            }
        }
    }
    @State var percentProgress: CGFloat = 0
    @State var timerIsActive = false
    @State var season = 0
    
    func startTimer() {
        withAnimation{
            timerIsActive = true
            currentTime = endTime
            season += 1
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                currentTime -= 1
                if currentTime == 0 {
                    timerIsActive = false
                    timer.invalidate()
                }
            }
        }
    }
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ///Header
                Text("All-In Timer")
                    .foregroundColor(Color.white)
                    .font(Font.custom("AvenirNextLTPro-Bold", size: 22))
                    .padding(.bottom, 48)
                
                /// Task
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
                .padding(.bottom, 36)
                
                /// Count
                ZStack {
                    Circle()
                        .trim(from: 0, to: percentProgress)
                        .stroke(Color.greyDark, lineWidth: 120)
                        .frame(width: proxy.size.width - 150)
                        .rotationEffect(.degrees(-90))
                        .blur(radius: 8)
                        
                    Circle()
                        .trim(from: 0, to: percentProgress)
                        .stroke(Color.blueMain, lineWidth: 10)
                        .padding(42)
                        .rotationEffect(.degrees(-90))
                    Circle()
                        .fill(Color.purpleDark)
                        .shadow(color: .blueMain.opacity(0.4), radius: 16)
                        .padding(48)
                        
                        .overlay {
                            Text(currentTime.toTimeString())
                                .foregroundColor(Color.white.opacity(0.8))
                                .font(Font.custom("AvenirNextLTPro-Regular", size: 64))
                        }
                }
                .padding(16)
                .padding(.bottom, 20)
                
                ProgressCircle(season: season)
                
                Button {
                    startTimer()
                } label: {
                    Circle()
                        .fill(Color.blueMain)
                        .frame(width: 80)
                        .overlay {
                            Image(systemName: timerIsActive ? "pause" : "play")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                        
                }
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .padding()
        .background(Color.purpleDark)
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
                .frame(width: 140, height: 1)
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(Color.purpleLight)
                        .frame(width: CGFloat((140.0 / 3) * Float(season)), height: 1)
                }
            HStack {
                PositionCircle(index: 0, season: season)
                ForEach(1..<4) { index in
                    Spacer()
                    PositionCircle(index: index, season: season)
                }
            }
        }
        .frame(width: 140)
        .padding(.bottom, 36)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 14 Pro Max")
    }
}


// MARK: TODO
/// - Make the clock
/// - Make cicle
///     - Extract component status
/// - Build the menu
/// - Build configuration screen
///  - Build the task title preferences
///  - Add songs
