//
//  CustomStringConvertible.swift
//  APNUtil
//
//  Created by Aaron Nance on 3/26/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

extension CustomStringConvertible {
    
    public var descriptionCharCount: Int { description.count }
    
    /// Utility function for printing description in console via "myobject.prnt()"
    func prnt() { Swift.print(self.description) }
    
    func centerPadded(toLength len: Int, withPad pad: Character = " ") -> String {
        
        description.centerPadded(toLength: len, withPad: pad)
        
    }
    
    func leftPadded(toLength len: Int, withPad pad: Character = " ") -> String {
        
        description.leftPadded(toLength: len, withPad: pad)
        
    }
    
    func rightPadded(toLength len: Int, withPad pad: Character = " ") -> String {
        
        description.rightPadded(toLength: len, withPad: pad)
        
    }
    
}
