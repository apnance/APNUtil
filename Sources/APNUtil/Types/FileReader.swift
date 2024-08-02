//
//  FileReader.swift
//  APNUtil
//
//  Created by Aaron Nance on 2/23/22.
//  Copyright © 2022 Aaron Nance. All rights reserved.
//

import Foundation

public typealias FileName   = String
public typealias FileType   = String
public typealias Count      = Int
public typealias Line       = String

public struct FileReader {
    
    /// Reads a newline delimted file returning a Set<String> with each element being one line from the file.
    public static func getLines(_ fileName: FileName,
                     fileType: FileType = "txt") -> Set<Line> {
        
        var words = Set<String>()
        
        if let path = Bundle.main.path(forResource: fileName,
                                       ofType: fileType) {
            
            do {
                
                let text = try String(contentsOfFile: path)
                words = Set(text.components(separatedBy: "\n"))
                
            } catch { print("Error reading file: \(path)") }
            
        }
        
        return words /*EXIT*/
    }
    
}
