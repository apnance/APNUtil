//
//  AttributedString.swift
//
//
//  Created by Aaron Nance on 9/8/24.
//

import Foundation

public extension NSAttributedString {
    
    // Concatenates two `NSAttributedString`s
    static func + (left: NSAttributedString,
                   right: NSAttributedString) -> NSAttributedString
    {
        
        let concat = NSMutableAttributedString()
        concat.append(left)
        concat.append(right)
        
        return concat
        
    }
    
}

@available(iOS 15, *)
public extension AttributedString {
    
    /// Returns NSAttributedString version of `self`
    var asNSAS: NSAttributedString { NSAttributedString(self) }
    
    var string: String { NSAttributedString(self).string }
    
    var isEmpty: Bool { characters.count == 0 }
    
    /// Trims any leading newline characters from characters array.
    mutating func trimLeadingNewlines() {
        
        trimLeading("\n")
    }
    
    /// Trims any trailing newline characters from characters array.
    mutating func trimTrailingNewlines() {
        
        trimTrailing("\n")
        
    }
    
    /// Trims all leading `toTrim` `Character`s
    mutating func trimLeading(_ toTrim: Character) {
        
        while characters.first == toTrim { characters.removeFirst() }
        
    }
    
    /// Trims all trailing `toTrim` `Character`s
    mutating func trimTrailing(_ toTrim: Character) {
        
        while characters.last == toTrim { characters.removeLast() }
        
    }
    
}

@available(iOS 15, *)
public extension String {
    
    /// Return a copy `self` as an `AttributedString`
    var asAS: AttributedString { AttributedString(self) }
    
}
