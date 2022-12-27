//
//  Nil.swift
//  APNUtil
//
//  Created by Aaron Nance on 12/31/18.
//  Copyright © 2018 Aaron Nance. All rights reserved.
//

import Foundation

/// Mutually exclusive or check for nil
///
/// - returns: false if both `o1` and `o2` are `nil` or both are not `nil`.  Returns `true` if one is `nil`
/// and the other not `nil`
///
/// - note: read as "either this or that are not nil?"
public func either(_ o1: Any?, or o2: Any?) -> Bool {
    
    // nil, nil
    if (o1.isNil && o2.isNil) { return false /*EXIT*/ }
    
    // not-nil, not-nil
    else if (o1.isNotNil && o2.isNotNil) { return false /*EXIT*/ }
    
    // nil, not-nil || not-nil, nil
    else { return true /*EXIT*/ }
    
}

/// Neither optionals contains a value(both nil).
///
/// - returns:true iff both `o1` and `o2` are `nil`
///
/// - note: read as "neither this nor that contain values?"
public func neither(_ o1: Any?, nor o2: Any?) -> Bool {
    
    return (o1 == nil && o2 == nil)
    
}

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
