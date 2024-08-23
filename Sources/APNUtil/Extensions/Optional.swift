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

public extension [String]? {
    
    /// Attempts to retrieve `String` `Element` numbered `i`.
    ///
    /// - important: queries work the same when `self` is nil.
    /// If `self` is nil, this method returns an empty string for all values of `i`
    /// 
    /// - returns: the `String` `Element` at index `i` if it exists, an empty `String` otherwise.
    func elementNum(_ i: Int) -> String {
        
        guard i >= 0,
              let args = self,
              args.lastUsableIndex >= i
        else { return "" /*EXIT: Not Found*/ }
        
        return args[i]
        
    }
    
    /// Returns the number of `Element`s, 0 if `self` is `nil`.
    var elementCount: Int { self?.count ?? 0 }
    
}
