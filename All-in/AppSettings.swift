//
//  AppSettings.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 20/07/23.
//

import Foundation

class AppSettings: ObservableObject {
    @Published var sessions = 4
    @Published var shortBreak = 5
    @Published var longBreak = 15
    @Published var focuse = 25
    
    func save(focuse: Int, shortBreak: Int, longBreak: Int, session: Int) {
        self.shortBreak = shortBreak
        self.longBreak = longBreak
        self.focuse = focuse
        self.sessions = sessions
    }
}
