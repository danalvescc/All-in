//
//  ContentView.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 14/07/23.
//

import SwiftUI

var endTime = 0.5 * 60

struct ContentView: View {
    @State var currentTime = 0.0
    @State var percentProgress: CGFloat = 0
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                print("Timer fired!")
                currentTime += 1.0
            withAnimation(.linear) {
                percentProgress = currentTime / endTime
                
            }
                if currentTime == endTime {
                    timer.invalidate()
                }
        }
    }
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("All-In Timer")
                    .foregroundColor(Color.white)
                    .font(Font.custom("AvenirNextLTPro-Bold", size: 22))
                    .padding(.bottom, 48)
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
                
                ZStack {
                    Circle()
                        .trim(from: 0, to: percentProgress)
                        .stroke(Color.greyDark, lineWidth: 120)
                        .frame(width: proxy.size.width - 150)
                        .rotationEffect(.degrees(-90))
                        
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
                            Text("05:24")
                                .foregroundColor(Color.white.opacity(0.8))
                                .font(Font.custom("AvenirNextLTPro-Regular", size: 64))
                        }
                }
                .padding(16)
                .padding(.bottom, 20)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.greyDark)
                        .frame(width: 140, height: 1)
                        .overlay(alignment: .leading) {
                            Rectangle()
                                .fill(Color.purpleLight)
                                .frame(width: 45, height: 1)
                        }
                    HStack {
                        Circle()
                            .fill(Color.purpleLight)
                            .frame(width: 16)
                        Spacer()
                        Circle()
                            .fill(Color.purpleLight)
                            .frame(width: 24)
                            .overlay {
                                Circle()
                                    .fill(Color.purpleDark)
                                    .frame(width: 14)
                            }
                        Spacer()
                        Circle()
                            .fill(Color.greyDark)
                            .frame(width: 16)
                        Spacer()
                        Circle()
                            .fill(Color.greyDark)
                            .frame(width: 16)
                    }
                }.frame(width: 140)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .padding()
        .background(Color.purpleDark)
        .onAppear {
            startTimer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 14 Pro Max")
    }
}
