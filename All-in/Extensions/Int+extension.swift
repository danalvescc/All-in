//
//  Int+extension.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 18/07/23.
//

import Foundation

struct TimeParts: CustomStringConvertible {
    var seconds = 0
    var minutes = 0
    
    var description: String {
        return NSString(format: "%02d:%02d", minutes, seconds) as String
    }
}

extension Int {
    func toTimeParts() -> TimeParts {
        let seconds = self
        var mins = 0
        var secs = seconds
        
        if seconds >= 60 {
            mins = Int(seconds / 60)
            secs = Int(seconds % 60)
        }
        
        return TimeParts(seconds: secs, minutes: mins)
    }
    
    func toTimeString() -> String {
        return toTimeParts().description
    }
}
