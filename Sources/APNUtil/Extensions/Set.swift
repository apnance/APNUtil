//
//  Set.swift
//  APNUtil
//
//  Created by Aaron Nance on 9/23/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import Foundation

public extension Set {
    
    /// Inserts the given elements into via self.union(element)
    mutating func insert(_ elements:[Element]?) {
        
        if let elements = elements { self = self.union(elements) }
        
    }
    
}

public extension Set where Element: Hashable {
    
    /// Replaces all `Elements` with the result of calling applying()  on those `Elements`.
    ///
    /// - parameter applying: a closure that takes an `Element` and returns an `Element`.
    ///  This closure is called on each `Element` in the `Set` replacing old values with newly
    ///  generated values.
    ///
    /// ```
    /// // ex.
    /// var colors = Set<String>(["RED","YeLlOw","BLue"])
    ///
    ///     colors.clean( { $0.lowercased() } )
    ///
    /// // Result: ["red","yellow","blue"]
    /// ```
    ///
    mutating func clean(_ applying: (Element) -> Element)  {
        
        var cleaned = Set<Element>()
        
        for word in self {
            
            let word = applying(word)
            
            cleaned.insert(word)
            
        }
        
        self = cleaned
        
    }
    
}
