//
//  CountableClosedRange.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/5/17.
//  Copyright © 2017 Nance. All rights reserved.
//

import UIKit

public extension CountableClosedRange {

    static func ValidRangeFrom(textFieldOne tf1: UITextField,
                               textFieldTwo tf2: UITextField) -> CountableClosedRange<Int> {

        var op1 = Int(tf1.text!) ?? 0
        var op2 = Int(tf2.text!) ?? 0

        // Order Start/End
        (op1, op2) = op1 > op2 ? (op2, op1) : (op1, op2)
        
        return op1...op2
        
    }
    
}
