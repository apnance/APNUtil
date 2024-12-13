//
//  String.swift
//  APNUtil
//
//  Created by Aaron Nance on 1/29/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import UIKit

public extension String.SubSequence {
    
    var string: String { String(self) }
    
}

// - MARK: - Tweak
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
    ///
    /// # Example #
    /// ```swift
    /// // ex.
    ///         let shucked = "[shuck me]".shuck() // returns "shuck me"
    ///
    ///         let corny   = "HuskCornHusk".shuck(4) // returns "Corn"
    /// ```
    func shuck(_ n: Int = 1) -> String {
        
        String(dropLast(n).dropFirst(n))
        
    }
    
    /// - Returns: Returns a copy of `self` with all leading/trailing and duplicate spaces removed.
    ///
    /// ```
    ///     // e.g.
    ///     "    Tidy     Me!   ".tidy() == "Tidy Me!"
    func tidy() -> String {
        
        trim().replacingOccurrences(of: " +",
                                    with: " ",
                                    options: .regularExpression)
        
    }
    
    /// !self.isEmpty
    var isNotEmpty: Bool { !self.isEmpty }
    
    /// Returns true if `self` is non-empty and begins with letter
    var hasAlphaPrefix: Bool { (first ?? Character(" ")).isLetter }
    
    /// Returns true if `self` is non-empty and begins with a number
    var hasNumericPrefix: Bool { (first ?? Character(" ")).isNumber }
    
    /// Returns true if `self` starts with  "http"
    ///
    /// - note: comparison is case insensitive  thus returns true for "http",
    /// "HTTP", "hTtP", etc.
    /// - note: comparison is only for prefix of "http" thus "https" and all its
    ///  case variations would return  true as well.
    var hasHTTPPrefix: Bool { self.lowercased().hasPrefix("http") }
    
    /// Returns a copy of this string lowercased and stripped of spaces.
    static func lowerNoSpaces(_ word: String) -> String {
        
        var copy    = word
        copy        = copy.replacingOccurrences(of: " ", with: "")
        copy        = copy.lowercased()
        
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
    /// 
    /// # Example #
    /// ```swift
    ///     // ex.
    ///     "A".base26StringToInt   == 0
    ///     "Z".base26StringToInt   == 25
    ///     "AA".base26StringToInt  == 26
    ///     "AAB".base26StringToInt == 703
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
    
    
    /// Returns a `DateFormatter` with `locale` set to device's current `Locale`
    private var localFormatter: DateFormatter {
        
        let dateFormatter = DateFormatter()
        
        // Set the locale to the current locale
        dateFormatter.locale = Locale.current
        
        return dateFormatter
        
    }
    
    /// Converts a string in format "MM/dd/yy" to a Date object.
    ///
    /// - important: calling this on an invalid date-string triggers a runtime error.
    /// Use `simpleDateMaybe` where there is a chance the string might not be
    /// a valid `String` representation of a `Date`.
    /// - note: the `Date` returned is set to the hour of the local time zone.
    var simpleDate: Date { simpleDateMaybe! }
    
    /// Like `simpleDate` but returns nil if `self` doesn't contain a valid `String`
    /// encoding of a `Date`.
    var simpleDateMaybe: Date? {
        
        let formatter           = localFormatter
        formatter.dateFormat    = "MM/dd/yy"
        
        return formatter.date(from: self)
        
    }
    
    /// Converts a string in format "yyyy-MM-dd HH:mm:ss Z" to a `Date` object.
    ///
    /// - important: calling this on an invalid date-string triggers a runtime error.
    /// Use `fullDateMaybe` where there is a chance the string might not be
    /// a valid `String` representation of a `Date`.
    var fullDate: Date { fullDateMaybe! }
    
    /// Like `fullDate` but returns nil if `self` doesn't contain a valid `String`
    /// encoding of a `Date`.
    var fullDateMaybe: Date? {
        
        let formatter           = DateFormatter()
        formatter.dateFormat    = "yyyy-MM-dd HH:mm:ss Z"
        
        let maybeDate = formatter.date(from: self)
        
        return maybeDate
        
    }
    
    /// Returns the offset from UTC for a date string formatted as "1983-12-01 10:10:10 -0700"
    /// The return value would be "-0700" for this date `String`.
    var timeZoneOffset: String {
        
        let timeZoneOffset = String(suffix(5))
        
        return timeZoneOffset
        
    }
    
}

// MARK: - Conversions
public extension String {
    
    func toArray() -> [String] { map{ String($0) } }
    
    /// Replaces whitespace with whitespace wildcards and escapes all characters in string that are Regular Expression tokens.
    var asRegularExpression: String {
        var regex = self
        
        /// Regex Tokens
        regex = regex.replacingOccurrences(of: "([$^~.+*?{}():!\\[\\]])", with: "\\\\$0", options: [.regularExpression])
        
        /// Whitespace
        regex = regex.replacingOccurrences(of: "\\s+", with: "\\\\s\\+", options: [.regularExpression])
        
        
        return regex
        
    }
    
}

// - MARK: - Fontify
public extension String {
    
    /// ASCIIFont definition to use to format fontified output.
    enum FontifyFont { case small, mini}
    
    /// Converts the string to ASCII-art version of itself.
    /// - Parameter font: ASCIIFont definition to use.
    /// - Returns: An ASCII-art version of self formatted to specification found in `font`
    func fontify(_ font: FontifyFont) -> String {
        
        switch font {
                
            case .small:    return ASCIIFontSmall().fontify(self)
            case .mini:     return ASCIIFontMini().fontify(self)
                
        }
        
    }
    
}

// - MARK: - Obfuscate
public extension String {
    
    func shift(by: Int) -> String {
        
        assert(by >= -45 && by <= 45)
        
        var shifted = ""
        let low     = Int(Character(" ").asciiValue!)
        let high    = Int(Character("~").asciiValue!)
        
        for char in self {
            
            var asciiVal    = Int(char.asciiValue!) + by
            
            if asciiVal > high {        // wrap after high character
                
                asciiVal = (low - 1) + (asciiVal - high)
                
            } else if asciiVal < low {  // Wrap after low character
                
                asciiVal = (high + 1) - (low - asciiVal)
                
            }
            
            assert(asciiVal >= low && asciiVal <= high,
                   "ASCII Value out of rante(\(low),\(high))")
            
            let shiftedUni  = UnicodeScalar(UInt8(asciiVal))
            
            shifted.append(Character(shiftedUni))
            
        }
        
        return shifted
        
    }

    var obfuscated: String {
        
        let shiftBy = (5...45).random()
        let key     = "A".shift(by: shiftBy)
        var silly   = shift(by: shiftBy)
        
        silly += key
        
        return silly
        
    }
    
    var unobfuscated: String {
        
        var serious = self
        let key     = Character(String(serious.removeLast()))
        let shiftBy = Int(Character("A").asciiValue!) - Int(key.asciiValue!)
        
        return serious.shift(by: shiftBy)
        
    }
    
}

// - MARK: - Utilities
public extension String {
    
    /// Returns a string highlighting the first difference between `self` and `other`
    func diff(with other: String) -> String {
        
        if self == other { return "" /*EXIT*/ }
        
        let minLength = min(self.count, other.count)
        
        for i in 0..<minLength {
            let index1 = self.index(self.startIndex, offsetBy: i)
            let index2 = other.index(other.startIndex, offsetBy: i)
            
            if self[index1] != other[index2] {
                
                
                let char1 = self[index1]
                let char2 = other[index2] == "\n" ? "\\n" : String(other[index2])
                
                var result = self
                result.replaceSubrange(index1...index1, with: "[\(char1)|\(char2)]")
                
                return result
            }
            
        }
        
        // If no differences are found, return string1 with brackets around the
        // first additional character if string2 is longer
        if self.count < other.count {
            
            var result = self
            
            let additionalChar = other[other.index(other.startIndex, offsetBy: self.count)]
            let differingChar = additionalChar == "\n" ? "\\n" : String(additionalChar)
            
            result.append("[\(differingChar)]")
            
            return result
            
        }
        
        return self
    }
    
    //    func diff6(_ string1: String, _ string2: String) -> String {
    //        let minLength = min(string1.count, string2.count)
    //
    //        for i in 0..<minLength {
    //            let index1 = string1.index(string1.startIndex, offsetBy: i)
    //            let index2 = string2.index(string2.startIndex, offsetBy: i)
    //
    //            if string1[index1] != string2[index2] {
    //                var result = string1
    //                let differingChar = string2[index2] == "\n" ? "\\n" : String(string2[index2])
    //                result.replaceSubrange(index1...index1, with: ">\(differingChar)<")
    //                return result
    //            }
    //        }
    //
    //        // If no differences are found, return string1 with brackets around the first additional character if string2 is longer
    //        if string1.count < string2.count {
    //            var result = string1
    //            let additionalChar = string2[string2.index(string2.startIndex, offsetBy: string1.count)]
    //            let differingChar = additionalChar == "\n" ? "\\n" : String(additionalChar)
    //            result.append(">\(differingChar)<")
    //            return result
    //        }
    //
    //        return string1
    //    }
    
    
    //    func diff5(_ string1: String, _ string2: String) -> String {
    //        let minLength = min(string1.count, string2.count)
    //
    //        for i in 0..<minLength {
    //            let index1 = string1.index(string1.startIndex, offsetBy: i)
    //            let index2 = string2.index(string2.startIndex, offsetBy: i)
    //
    //            if string1[index1] != string2[index2] {
    //                var result = string1
    //                let differingChar = string2[index2] == "\n" ? "\\n" : String(string2[index2])
    //                result.insert(">", at: index1)
    //                let insertIndex = result.index(after: index1)
    //                result.insert(contentsOf: differingChar, at: insertIndex)
    //                result.insert("<", at: result.index(insertIndex, offsetBy: differingChar.count))
    //                return result
    //            }
    //        }
    //
    //        // If no differences are found, return string1 with brackets around the first additional character if string2 is longer
    //        if string1.count < string2.count {
    //            var result = string1
    //            let additionalIndex = string1.endIndex
    //            let additionalChar = string2[string2.index(string2.startIndex, offsetBy: string1.count)]
    //            let differingChar = additionalChar == "\n" ? "\\n" : String(additionalChar)
    //            result.insert(">", at: additionalIndex)
    //            result.append(differingChar)
    //            result.append("<")
    //            return result
    //        }
    //
    //        return string1
    //    }
    
    //    func diff2(_ string1: String, _ string2: String) -> String {
    //
    //        let minLength = min(string1.count, string2.count)
    //
    //        for i in 0..<minLength {
    //
    //            let index1 = string1.index(string1.startIndex, offsetBy: i)
    //            let index2 = string2.index(string2.startIndex, offsetBy: i)
    //
    //            if string1[index1] != string2[index2] {
    //                var result = string1
    //                result.insert("*", at: index1)
    //                return result
    //            }
    //
    //        }
    //
    //        // If no differences are found, return string1 with an asterisk appended if string2 is longer
    //        if string1.count < string2.count {
    //
    //            return string1 + "*"
    //
    //        }
    //
    //        return string1
    //    }
    
    
    /// Returns an exhaustive array of all character differences between `self` and other.
    func diffDeep(with other: String) -> [(index: Int, char1: Character, char2: Character)] {
        
        let maxLength   = max(self.count, other.count)
        var differences = [(index: Int, char1: Character, char2: Character)]()
        
        for i in 0..<maxLength {
            
            let char1: Character = i < self.count ? self[self.index(self.startIndex, offsetBy: i)] : "*"
            let char2: Character = i < other.count ? other[other.index(other.startIndex, offsetBy: i)] : "*"
            
            if char1 != char2 {
                differences.append((index: i, char1: char1, char2: char2))
            }
            
        }
        
        return differences
        
    }
    
}


// - MARK: - Operators
infix operator =~ : ComparisonPrecedence

@available(iOS 16.0, *)
public extension String {
    
    /// String comparison operator that returns true if the `String` encoded
    /// regular expression on the RHS matches the `String` on the LHS.
    static func =~ (lhs: String, rhs: String) -> Bool {
        do {
            
            return lhs.wholeMatch(of: try Regex(rhs)) != nil
            
        } catch {
            
            print("Invalid regular expression: \(error.localizedDescription)")
            return false
            
        }
        
    }
    
}
