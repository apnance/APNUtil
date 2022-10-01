//
//  Int.swift
//  APNUtil
//
//  Created by Aaron Nance on 5/14/17.
//  Copyright © 2017 Nance. All rights reserved.
//

import Foundation

public extension Bool {

    /// - returns: a random `Bool` value
    static func random() -> Bool { return Double.random > 0.5 }
    
    /// An abbreviated `String` representation of this `Bool` ("T" for true, "F" for false)
    var abbr: String { self ? "T" : "F" }
    
}
