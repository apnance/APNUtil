//
//  Sequence.swift
//  RoriMath
//
//  Created by Aaron Nance on 11/17/20.
//  Copyright © 2020 Nance. All rights reserved.
//

import Foundation

public extension Sequence where Element : AdditiveArithmetic {
    
    /// Returns the sum of  all `Ints` in the Array<Int>
    func sum() -> Element { reduce(.zero, +) }
        
}

public extension Sequence {
    
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        
        var result = Array(self)
        result.shuffle()
        
        return result
        
    }
}

