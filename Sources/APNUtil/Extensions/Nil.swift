//
//  Nil.swift
//  APNUtil
//
//  Created by Aaron Nance on 12/31/18.
//  Copyright © 2018 Aaron Nance. All rights reserved.
//

import Foundation

/// Returns boolean indicating whether both arguments are both nil or both not nil.
///
/// Returns false only when one argument is nil and the other not nil.
public func nilStateSame<T>(_ first: T?, _ second: T?) -> Bool {
    
    if first == nil && second == nil { return true /*EXIT*/ }
    
    if first != nil && second != nil { return true /*EXIT*/ }
    
    return false /*EXIT*/
    
}

/// Returns true iff neither argument is nil
public func notNil<T,U> (val1: T?, val2: U?) -> Bool {
    
    val1 != nil && val2 != nil
    
}

/// Returns true iff none of the arguments are nil.
public func noNils (_ values: Any?...) -> Bool {
    
    for value in values {
        if value == nil { return false /*EXIT*/ }
    }
    
    return true /*EXIT*/
    
}

/// Returns true iff all argument values are nil
public func allNils (_ values: Any?...) -> Bool {
    
    for value in values {
        if value != nil { return false /*EXIT*/ }
    }
    
    return true /*EXIT*/
    
}

/// Returns true if any of the provided arguments are nil
public func someNils (_ values: Any?...) -> Bool {
    
    for value in values {
        
        if value == nil { return true /*EXIT*/ }
        
    }
    
    return false /*EXIT*/
    
}

/// Returns the number of arguments with nil values.
public func nilCount (_ values: Any?...) -> Int {
    
    var nils = 0
    
    for value in values { if value == nil { nils += 1 } }
    
    return nils /*EXIT*/
    
}
