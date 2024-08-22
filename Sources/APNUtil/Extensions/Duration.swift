//
//  Duration.swift
//  
//
//  Created by Aaron Nance on 8/20/24.
//

import Foundation

@available(iOS 16.0, *)
public extension Duration {
    
    /// Number of attoseconds in a second.
    static var attosPerSecond = 1000000000000000000.0
    
    /// Total number of seconds in `Duration`.
    var totalSeconds: Double { Double(components.seconds) + (Double(components.attoseconds) / Self.attosPerSecond) }
    
    /// Total number of minutes in `Duration`.
    var totalMinutes: Double { totalSeconds / 60.0 }
    
}
