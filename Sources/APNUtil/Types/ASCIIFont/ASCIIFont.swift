//
//  ASCIIFont.swift
//  APNUtil
//
//  Created by Aaron Nance on 7/11/24.
//

import Foundation

public typealias FontDict = [String : String]

/// Simple protocol defining the String.fontify() mechanism's font defitnion.
/// - important: Run check() on your ASCIIFont adopter to check your work.
protocol ASCIIFont {
    
    var alphabet: FontDict { get }
    var lineHeight: Int { get }
    
}

extension ASCIIFont {
    
    /// Characters ASCIIFont deems required basic ASCII characters to include in alphabet.
    private var requiredCharacters: [String] {
        
        [" ", "A","B","C","D","E","F",
         "G","H","I","J","K","L","M",
         "N","O","P","Q","R","S","T",
         "U","V","W","X","Y","Z","1",
         "2","3","4","5","6","7","8",
         "9","0","a","b","c","d","e",
         "f","g","h","i","j","k","l",
         "m","n","o","p","q","r","s",
         "t","u","v","w","x","y","z",
         ".","!","?","/","\\","\"","'",
         ",",";",":","%","$","#","@",
         "&","*","(",")","-","=","+",
         "^","[","]","_",">","<","`","~"]
    }
    
    /// Utility for checking that Font alphabet characters are correctly formed.
    func check() {
        
        // Letter Dims
        let (minWidth, maxWidth, height) = getMaxMin()
        
        assert(lineHeight > 0)
        assert(height == lineHeight)
        
        assert(maxWidth > 0)
        assert(minWidth > 0)
        
        // Font Completion
        var missing = [String]()
        
        requiredCharacters.forEach {
            
            if alphabet[$0].isNil { missing.append($0) }
            
        }
        
        assert(missing.isEmpty, "Required Character\(missing.count > 1 ? "s" : "") Missing: \(missing.asCommaSeperatedString(conjunction: "and"))")
        
        print("\(#function): Passed!")
        
    }
    
    /// Fontified version of characters missing from alphabet.
    private var missingCharacterPlaceHolder: String {
        
        let maxMin    = getMaxMin()
        var missing = ""
        missing     += " \(String(repeating:"¿", count: maxMin.minWidth)) \n"
        
        return String(repeating: missing, count: maxMin.height)
    }
    
    /// Splits an alphabet character into row lines.
    private func charToRows(_ char: Character) -> [String.SubSequence] {
        
        let rows = (alphabet[String(char)] ?? missingCharacterPlaceHolder).split(separator: "\n")
        
        return rows
        
    }
    
    
    /// Calculates and returns the max/min widths of characters present in alphabet as well as the height of all characters.
    /// - note: max/min height should be the same.
    /// - Returns: max/min widths of font found in this `ASCIIFont` as well as the height.
    private func getMaxMin() -> (minWidth: Int, maxWidth: Int, height: Int) {
        var maxHeight   = 0
        var minHeight   = Int.max
        
        var maxWidth    = 0
        var minWidth    = Int.max
        
        for (char, charRows) in alphabet {
            
            let rows = charRows.split(separator: "\n")
            
            let height  = rows.count
            let width   = rows.first?.count ?? 0
            
            maxHeight   = max(height, maxHeight)
            minHeight   = min(height, minHeight)
            
            maxWidth    = max(width, maxWidth)
            minWidth    = min(width, minWidth)
            
            assert(maxHeight == minHeight,
                   "\(char) : min ht: \(minHeight) != max ht: \(maxHeight)")
            
        }
        
        return (minWidth, maxWidth, maxHeight)
        
    }
    
    /// Converts the string to ASCII-art version of itself.
    func fontify(_ text: String) -> String {
        
        let charDims = getMaxMin()
        
        let textLines   = text.split(separator: "\n",
                                     omittingEmptySubsequences: false) // <- Account for empty lines in text
        
        let fontHeight  = charDims.height
        
        let fontifiedLineBreak = Array(repeating: " ", count: fontHeight)
        
        var fontified   = ""
        
        // TEXT LINES
        for textLine in textLines {
            
            var fontifiedLine = Array(repeating: "", count: fontHeight)
            
            if textLine.count == 0 {
                
                fontifiedLine = fontifiedLineBreak
                
            } else {
                
                // CHAR LINES
                for char in textLine {
                    
                    let charLines = charToRows(char)
                    
                    for (lineNum, charLine) in charLines.enumerated() {
                        
                        fontifiedLine[lineNum] += String(charLine)
                        
                    }
                    
                }
                
            }
            
            for fontifiedRow in fontifiedLine {
                
                fontified += "\(fontifiedRow)\n"
                
            }
            
        }
        
        return fontified
        
    }
    
}
