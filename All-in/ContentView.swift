//
//  ContentView.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 14/07/23.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        TabView() {
            TimerView()
                .tabItem {
                    Image(systemName: "clock")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "slider.vertical.3")
                }
        }.accentColor(.blueMain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12")
    }
}


// MARK: TODO
/// - Make the clock
/// - Make cicle
///     - Extract component status
/// - Build the menu
/// - Build configuration screen
/// - Build the task title preferences
/// - Add songs
/// - Add conicGradient animated on clock activated
