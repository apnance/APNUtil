//
//  Math.swift
//  APNUtil
//
//  Created by Aaron Nance on 9/27/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import Foundation

/// Returns the absolute value of the difference between `l` and `r`
public func absDiff(_ l: Int,_ r: Int) -> Double {
    
        return absDiff(Double(l),
                       Double(r))
    
}

/// Returns the absolute value of the difference between `l` and `r`
public func absDiff(_ l: Float,_ r: Float) -> Double {
    
        return absDiff(Double(l),
                       Double(r))
    
}

/// Returns the absolute value of the difference between `l` and `r`
public func absDiff(_ l: Double,_ r: Double) -> Double { return abs(l-r) }
