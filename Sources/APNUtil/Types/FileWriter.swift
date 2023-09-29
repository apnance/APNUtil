//
//  FileWriter.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/12/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

/// Class for writing data to files.
public class FileWriter {
    
    /// Writes the contents of `text` to `/[filePath]/[filename]` on the mac.
    /// - note: For configuring app to write files to Mac HD, see:
    ///         https://stackoverflow.com/questions/47267238/write-to-a-file-xcode-macos
    public static func writeToTmp(text: String,
                                  filePath: String = "/tmp/",
                                  fileName: String) {
        
        let filePath = "/tmp/\(fileName)".replacingOccurrences(of: "//",
                                                                      with: "/")
        
        try! text.write(toFile: filePath,
                        atomically: false,
                        encoding: .utf8)
        
        Utils.log("FileWriter: file written to: '\(filePath)'")
        
    }
    
}
