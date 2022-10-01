//
//  Operators.swift
//  APNUtil
//
//  Created by Aaron Nance on 1/30/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import Foundation

precedencegroup RandomFromRangePrecedence {
    
    associativity: right
    higherThan: MultiplicationPrecedence
    
}

infix operator .?.: RandomFromRangePrecedence

/// Returns a random number from rhs to lhs inclusive.
public func .?. (rhs: Int, lhs: Int) -> Int {
    
    var offset = 0
    let lBound = min(rhs, lhs)
    let uBound = max(rhs, lhs)
    
    // allow negative ranges
    if lBound < 0 { offset = abs(lBound) }
    
    let mini = UInt32(lBound + offset)
    let maxi = UInt32(uBound + 1 + offset)
    
    return Int(mini + arc4random_uniform(maxi - mini)) - offset
    
}

infix operator <+ : AssignmentPrecedence

/// Integral concatenation operator, concatenates `rhs` onto `lhs`
/// ```
/// var val = 1
/// val <+ 2        // val == 12
/// val <+ 999      // val == 12999
/// - important: there is no overflow checking
/// ```
public func <+ (lhs: inout Int, rhs: Int) {
    
    assert(rhs >= 0)
    
    var shift = 10
    var x = rhs
    let mult = lhs < 0 ? -1 : 1
    
    while x >= 10 {
        
        x /= 10
        shift *= 10
        
    }
    
    lhs = (lhs * shift) + (mult * rhs)
    
}
