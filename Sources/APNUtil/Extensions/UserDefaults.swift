//
//  UserDefaults.swift
//  APNUtil
//
//  Created by Aaron Nance on 1/29/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import Foundation

public extension UserDefaults {

    /// Prints all UserDefaults keys console.
    @objc static func printAllKeysWith(prefix: String) {
        
        getAllKeysWith(prefix: prefix).forEach {
            
            if $0.starts(with: prefix) { print("\($0) = \($1)") }
            
        }
        
    }
    
    /// Returns a dictionary of all items UserDefaults that have keys prefixed with prefix.
    @objc static func getAllKeysWith(prefix: String) -> [String: Any] {
        
        var keys = [String: Any]()
        
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            if key.hasPrefix(prefix) {
                
                keys[key] = value
            }
        }
        
        return keys /*EXIT*/
        
    }
    
}
