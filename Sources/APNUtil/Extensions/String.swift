//
//  String.swift
//  APNUtil
//
//  Created by Aaron Nance on 1/29/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import Foundation

public extension String.SubSequence {
    
    var string: String { String(self) }
    
}

public extension String {
    
    /// Passes itself to the provided closure returning the return value.
    func processed(_ applying: (String) -> String)  -> String { applying(self) }
    
    /// Trims all leading and trailing whitespace and new line characters
    func trim() -> String { trimmingCharacters(in: .whitespacesAndNewlines) }
    
    /// Returns the string created by trimming `Characters` off end of `Self` until its length equals `len`.
    /// Returns copy of `Self` if len is greater than `Self.count`
    /// - important: len must be greater than 0
    func rTrimTo(_ len: Int) -> String {
        
        assert(len > 0, "len expected to be greater than zero but was \(len)")
        if len > self.count { return self /*EXIT*/ }
        
        let range   = startIndex..<index(startIndex, offsetBy: len)
        
        return String(self[range])
        
    }
    
    /// Returns a copy of the string with the last `n` character(s) snipped from the right end.
    /// 
    /// - note: Default is 1 character snipped.
    func snip(_ n: Int = 1) -> String { String(dropLast(n)) }
    
    /// Returns a copy of the string with the first `n` and last `n` character(s) snipped from the right end.
    ///
    /// - note: Default is 1 character shucked from first and last of `String`.
    /// ````
    /// // ex.
    ///         let shucked = "[shuck me]".shuck() // returns "shuck me"
    ///
    ///         let corny   = "HuskCornHusk".shuck(4) // returns "Corn"
    func shuck(_ n: Int = 1) -> String {
        
        String(dropLast(n).dropFirst(n))
        
    }
    
    /// Returns a copy of this string lowercased and stripped of spaces.
    static func lowerNoSpaces(_ word: String) -> String {
        
        var copy = word
        
        copy = copy.replacingOccurrences(of: " ", with: "")

        copy = copy.lowercased()
        
        return copy
        
    }
    
}

// MARK: - Padding
public extension String {
    
    enum PaddingType { case left, right, center}
    
    /// Returns a copy of this string left padded to the specified length.
    ///
    /// - important: Specifying a padding length  less than the length of this string is treated as a negative padding and
    ///  results in the truncation of leading characters in excess of specified length.
    func leftPadded(toLength len: Int,
                    withPad pad: Character = " ") -> String { padded(toLength: len,
                                                                     type: .left, withPad: pad) }
    
    /// Returns a copy of this string right padded to the specified length.
    ///
    /// - important: Specifying a padding length  less than the length of this string is treated as a negative padding and
    ///  results in the truncation of trailing characters in excess of specified length.
    func rightPadded(toLength len: Int,
                     withPad pad: Character = " ") -> String { padded(toLength: len,
                                                                      type: .right, withPad: pad) }

    /// Returns a copy of this string center padded to the specified length.
    ///
    /// - important: Specifying a padding length  less than the length of this string is treated as a negative padding and
    ///  results in the truncation from both leading and trailing characters with the number of characters truncated being split
    ///  between left and right. If an uneven number of characters are to be padded or truncated, the padding or truncation is done
    ///  so as to favor the left side(i.e. left padding is always equal to the right padding or greater by one.  left truncation is always equal to
    ///  right truncation or less by one.
    func centerPadded(toLength len: Int,
                      withPad pad: Character = " ") -> String { padded(toLength: len, type: .center, withPad: pad) }
    
    /// Pads strings to specified length.  Truncation occurs when specified padding lenght is less than the character count of the `String`.
    /// For .center padding, padding added to the right side  is always &lt;= padding added to the left.
    /// In the case of truncation(i.e. len &lt; count), the number of characters trimmed from the right side is always %gt;= the number trimmed from the left..
    private func padded(toLength len: Int,
                        type: PaddingType,
                        withPad pad: Character) -> String {
        
        assert(len >= 0, "toLength must be greater >= 0 but is \(len)")
        
        switch type {
            
        case .center:
            
            let leftLen     = len
            let diff        = len - count
            let rightAdjust = min(diff / 2, diff - (diff / 2))
            let rightLen    = count + rightAdjust
            
            var text = padded(toLength: rightLen,
                              type: .right,
                              withPad: pad)
            
            text = text.padded(toLength: leftLen,
                               type: .left,
                               withPad: pad)
            
            return (text) /*EXIT*/
            
        case .left:
            
            if count < len {
                
                return String(repeatElement(pad,
                                            count: len - count)) + self /*EXIT*/
                
            } else {
                
                return String(suffix(len)) /*EXIT*/
                
            }
            
        case .right:
            
            return padding(toLength: len,
                           withPad: String(pad),
                           startingAt: 0) /*EXIT*/
            
        }
        
    }
    
    /// Adds a new line followed by a divider consisting of the specified char repeated to a width equal to `self.count`.
    mutating func addDivider(usingChar char: Character = "-") {
        
        self += "\n\(String(repeatElement(char,count: count)))"
        
    }
    
}

// MARK: - Numeric
public extension String {
    
    /// Converts a base 26 String representation of a number into Int
    /// e.g
    /// ```
    ///     // ex.
    ///     fromBase26String("A") == "0"
    ///     fromBase26String("Z") == "25"
    ///     fromBase26String("AA") == "26"
    ///     fromBase26String("AAB") == "703"
    /// ```
    ///
    /// - note: see Int.base26String for converting back to Int
    var base26StringToInt: Int? {
        
        var result = 0
        
        var digits = [String]()
        for char in self { digits.append(String(char).uppercased()) }
        
        for (power, strDigit) in digits.reversed().enumerated() {
            
            let digit = Int(strDigit.unicodeScalars.first?.value ?? 0) - 64
            
            guard digit > 0 && digit < 27
            else { return nil /*EXIT*/ }
                        
            result += Int(pow(Double(26), Double(power))) * digit
            
        }
                
        return result - 1 //A == 0, Z == 25, etc.
        
    }
    
}

// MARK: - Date
public extension String {
    
    // Converts a string in format "MM/dd/yy" to a Date object.
    var simpleDate: Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        
        let date = formatter.date(from: self)
        
        return date!

    }
    
    
    /// Like simpleDate but returns nil if `Self` doesn't contain a valid String encoding of a date.
    var simpleDateMaybe: Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        
        let maybeDate = formatter.date(from: self)
        
        return maybeDate
        
    }
    
}

// MARK: - Conversions
public extension String {
    
    func toArray() -> [String] { map{ String($0) } }
    
}

