//
//  JSONString.swift
//  APNUtil
//
//  Created by Aaron Nance on 9/23/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

public typealias JSONString = String

public extension JSONString{
    
    /// Returns an instance of type `T` from supplied `JSONstring`.
    func instance<T: Decodable>() -> T? {
        
        CodableArchiver.instanceFrom(jsonString: self)
        
    }
    
}

public extension JSONString? {
    
    /// Returns an instance of type `T` from supplied `JSONstring`.
    func instance<T: Decodable>() -> T? {
        
           CodableArchiver.instanceFrom(jsonString: self ?? "")
        
    }
    
}
