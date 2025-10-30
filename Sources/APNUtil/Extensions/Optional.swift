//
//  Optional.swift
//  APNUtil
//
//  Created by Aaron Nance on 9/14/22.
//  Copyright © 2022 Aaron Nance. All rights reserved.
//

import Foundation

public extension Optional {
    
    var isNil : Bool { self == nil }
    var isNotNil: Bool { self != nil }
    
}

public extension Optional where Wrapped: Collection {
    
    /// Returns true if self is nil or the collection is empty
    var isNilOrEmpty: Bool { self?.isEmpty ?? true }
    
}

public extension [String]? {
    
    /// Attempts to retrieve `String` `Element` numbered `i` eliminating the
    /// need to check if `i` is a valid index into the`self`.
    ///
    /// - important: queries work the same when `self` is `nil`. Any attempt to retrieve
    /// a non-existing element results in a return value of "".
    ///
    ///
    /// - returns: the `String` `Element` at index `i` if it exists, "" otherwise.
    func elementNum(_ i: Int) -> String {
        
        (self ?? []).elementNum(i)
        
    }
    
    /// Returns the number of `Element`s, 0 if `self` is `nil`.
    var elementCount: Int { self?.count ?? 0 }
    
}
