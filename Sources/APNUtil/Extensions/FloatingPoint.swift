//
//  FloatingPoint.swift
//  APNUtil
//
//  Created by Aaron Nance on 4/6/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import Foundation

public extension FloatingPoint {
    
    /// Converts the float from degrees to radians.
    var degreesToRadians: Self { return self * .pi / 180 }

    /// Converts the float from radians to degrees.
    var radiansToDegrees: Self { return self * 180 / .pi }
    
}
