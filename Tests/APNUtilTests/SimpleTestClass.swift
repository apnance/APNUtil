//
//  SimpleTestClass.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 5/19/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

/// A very simple Codable/Equatable class used for testing.
class SimpleTestClass: Codable, Equatable {
    
    let name: String?
    let number: Int?
    
    init(name: String?, number: Int?) { self.name = name; self.number = number }
    
    static func == (lhs: SimpleTestClass, rhs: SimpleTestClass) -> Bool {

        lhs.name == rhs.name && lhs.number == rhs.number

    }

}
