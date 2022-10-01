//
//  Bundle.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/12/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

public extension Bundle {
    
    /// Prints all `Bundle.main.infoDictioary` `keys`.
    static func printMainKeys() {
        
        for key in Bundle.main.infoDictionary!.keys {
            
            print(key)
            
        }
        
    }

    /// Prints all `Bundle.main.infoDictioary` `key/value` pairs.
    static func printMainKeyVals() {
        
        for (key, value) in Bundle.main.infoDictionary! {
            
            print("\(key) \(value)")
            
        }
        
    }
    
}
