//
//  TimerView.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 19/07/23.
//

import SwiftUI

enum ClockState: Int {
    case working = 300
    case shortPause = 5
    case longPause = 7
}

struct TimerView: View {
    @AppStorage("focuseTime") private var focuseTimeMemory = 25
    @AppStorage("shortBreakTime") private var shortBreakTimeMemory = 5
    @AppStorage("longBreakTime") private var longBreakTimeMemory = 15
    @AppStorage("sectionsToPause") private var sectionsToPauseMemory = 4
    init() {
        focuseTimeMemory = focuseTimeMemory == 0 ? 25 : focuseTimeMemory
        shortBreakTimeMemory = shortBreakTimeMemory == 0 ? 5 : shortBreakTimeMemory
        longBreakTimeMemory = longBreakTimeMemory == 0 ? 15 : longBreakTimeMemory
        sectionsToPauseMemory = sectionsToPauseMemory == 0 ? 4 : sectionsToPauseMemory
        
        
        currentEndTime = focuseTimeMemory * 60
        currentTime = focuseTimeMemory * 60
    }
    
    
    @State var currentEndTime = 1
    @State var clockState: ClockState = .working
    @State var currentTime = 0 {
        didSet {
            withAnimation(.linear(duration: 1)) {
                percentProgress = CGFloat(currentTime) / CGFloat(currentEndTime)
            }
        }
    }
    @State var percentProgress: CGFloat = 1
    @State var timerIsActive = false
    @State var season = 0
    @State var timer: Timer?
    
    func defineEndTime() {
        switch(clockState) {
        case .working:
            currentEndTime = focuseTimeMemory * 60
        case .shortPause:
            currentEndTime = shortBreakTimeMemory * 60
        case .longPause:
            currentEndTime = longBreakTimeMemory * 60
        }
    }
    
    func startTimer() {
        withAnimation {
            timerIsActive = true
            defineEndTime()
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                currentTime -= 1
                if currentTime == -1 {
                    timerIsActive = false
                    timer.invalidate()
                    
                    if clockState == .working && season < sectionsToPauseMemory - 1 {
                        clockState = .shortPause
                        currentTime = shortBreakTimeMemory * 60
                    } else if clockState == .working {
                        clockState = .longPause
                        currentTime = longBreakTimeMemory * 60
                    } else {
                        season = season == sectionsToPauseMemory - 1 ? 0 : season + 1
                        clockState = .working
                        currentTime = sectionsToPauseMemory * 60
                    }
                }
            }
        }
    }
    
    func pauseTimer() {
        timerIsActive = false
        timer?.invalidate()
    }
    
    var body: some View {
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
                GeometryReader { proxy in
                    ZStack {
                        ///Blur circle
                        Circle()
                            .trim(from: 0, to: percentProgress)
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
                    }.frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding(.bottom, 48)
                
                ProgressCircle(season: season)
                
                Button {
                    timerIsActive ? pauseTimer() : startTimer()
                } label: {
                    ZStack {
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
            .onAppear {
                if !timerIsActive {
                    currentTime = focuseTimeMemory * 60
                }
                    
            }
    }
}

struct ProgressCircle: View {
    var season: Int
    @AppStorage("sectionsToPause") private var sectionsToPause = 4
    
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
        .fill(Color.greyDark)
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
                .fill(Color.greyDark)
                .frame(width: 120, height: 1)
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(Color.purpleLight)
                        .frame(width: CGFloat((120.0 / 3) * Float(season)), height: 1)
                }
            HStack {
                PositionCircle(index: 0, season: season)
                ForEach(1..<sectionsToPause) { index in
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
    private var cornerRadius: CGFloat = 36.0
    @State private var isEditing = false
    @FocusState private var isFocused: Bool
    @State private var text = ""
    
    @AppStorage("activeTask") private var activeTask = "No task"
    
    
    func save() {
        activeTask = text
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.purpleLight)
                .frame(height: 72)
            HStack {
                if isEditing{
                    TextField("Input your task", text: $text)
                        .focused($isFocused)
                        .foregroundColor(Color.white)
                        .font(Font.custom("AvenirNextLTPro-Light", size: 22))
                        .onSubmit {
                            activeTask = text
                            isEditing = false
                        }
                        .focused($isFocused, equals: true)
                    Spacer()
                    Button {
                        isEditing = false
                    } label: {
                        Image(systemName: "x.circle")
                            .font(.system(size: 22))
                    }
                } else {
                    Text(activeTask)
                        .foregroundColor(Color.white)
                        .font(Font.custom("AvenirNextLTPro-Light", size: 22))
                    Spacer()
                    Button {
                        DispatchQueue.main.async { // Perform focus-related operations asynchronously
                            isEditing = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isFocused = true
                            }
                        }

                    } label: {
                        Image(systemName: "pencil.line")
                            .font(.system(size: 22))
                    }
                }
            }.foregroundColor(Color.white)
                .padding(.horizontal, cornerRadius)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}
