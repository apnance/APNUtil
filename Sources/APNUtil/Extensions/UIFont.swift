//
//  UIFont.swift
//  APNUtil
//
//  Created by Aaron Nance on 12/12/25.
//

import UIKit

// Centralized cache of all available font names
extension UIFont {
    
    /// Cached set of all valid names accepted by UIFont(name:size:)
    public static let allFontNames: Set<String> = {
        
        var names = Set<String>()
        
        // Add family names
        names.formUnion(UIFont.familyNames)
        
        // Add specific face names
        for family in UIFont.familyNames {
            names.formUnion(UIFont.fontNames(forFamilyName: family))
        }
        
        return Set(names.map { $0.lowercased() }) // normalize to lowercase
        
    }()
    
    /// Cached list of all valid font names sorted alphabetically.
    public static let allFontNamesSorted: [String] = { allFontNames.sorted() }()
    
    /// Case-insensitive validity check
    public static func isValidFontName(_ name: String) -> Bool {
        
        return allFontNames.contains(name.lowercased())
        
    }
    
}
