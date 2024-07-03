//
//  Int.swift
//  APNUtil
//
//  Created by Aaron Nance on 5/14/17.
//  Copyright © 2017 Nance. All rights reserved.
//

import UIKit

public extension Int {

    var double: Double { Double(self) }
    
    var isPrime: Bool {
        
        if self < 2 { return false /*EXIT*/ }
        
        var i = 2
        
        while ( i*i <= self ) {
            
            if (self % i == 0) { return false /*EXIT*/ }
        
            i += 1
            
        }
        
        return true
        
    }
    
    
    /// Returns the number of tens places as a multiple of 10.
    ///
    /// ```
    ///     // e.g.
    ///        0.size       == 1
    ///        1.size       == 1
    ///        -1.size      == 1
    ///        23.size      == 10
    ///        9999.size    == 1000
    ///        -9999.size   == 1000
    /// ```
    /// - note: source: ChatGPT
    var tens: Int {
        
        Int("1" + repeatElement("0", count: String(self.magnitude).count - 1))!
        
    }
    
    /// Returns the Int value as an [Int] array of its constituent digits.  Functionality is similar in concept to
    /// string splitting methods.
    ///
    /// Note: the array is returned in ascending order(i.e. ones at index 0, tens at index 1, etc.
    /// Note: If the Int is a negative number -1 is appended to end of array.
    var digits: [Int] {

        var digits = [Int]()
        var num = abs(self)
        
        repeat {
            
            digits.append(num % 10)
            
            num /= 10
            
        } while (num > 0)
        
        if self < 0 { digits.append(-1) }
        
        return digits
        
    }
    
    /// Returns a random `Int`
    static func random() -> Int { return Int(arc4random()) }
    
    /// Returns a random number from negative maxAbsoluteValue to maxAbsoluteValue
    static func randomNumber(maxAbsoluteValue: Int) -> Int {
        
        var max = maxAbsoluteValue
        
        max = abs(max)
        
        let randNumber = Int(arc4random_uniform(UInt32(max)))
        return randNumber * (arc4random_uniform(2) == 1 ? -1 : 1)
    }
    
    static func random(min: Int, max: Int) -> Int { random(in: min...max) }
    
    /// Decrements and returns value.
    mutating func decr() -> Int {
        
        self = self - 1
        
        return self
        
    }
    
    /// Increments and returns value.
    mutating func incr() -> Int {
        
        self = self + 1
        
        return self
        
    }

    /// Returns percent `self` is of `of` as a `Double` with optional rounding specification.
    func percent(of total: Int, roundedTo: Int? = nil) -> Double {
        
        if let roundedTo = roundedTo {
            
            return ((double / total.double) * 100).roundTo(roundedTo)
            
        } else {
            
            return ((double / total.double) * 100)
            
        }
        
    }

    /// Returns what percentile `self` is in of `of` as a `Double` with optional rounding
    func percentile(of total: Int, roundedTo: Int? = nil) -> Double {
        
        if let roundedTo = roundedTo {
            
            return (((total - (self - 1)).double / total.double) * 100).roundTo(roundedTo)
            
        } else {
            
            return (((total - (self - 1)).double / total.double) * 100)
            
        }
        
    }
    
    func factorial() -> Int {
        
        self <= 1 ? 1 : self * (self - 1).factorial()
        
    }
    
    
    /// Creates a new int by concatenating the provided Int onto `self`
    /// - Parameter int2: `Integer` to concatenate onto `self`
    /// - Returns: Integer
    /// - e.g. 12.concatenated(15) == 1215
    /// - note: yes it's a typo..
    func concatonated(_ i2: Int) -> Int? {
        
        Int(description + i2.description)
        
    }
    
    
    /// Tests if `self` is between `first` and `second` Int
    /// - Parameters:
    ///   - first: first inclusive bound
    ///   - second: second inclusive bound
    /// - Returns: Bool indicating whether `self` is between `first` and `second`
    ///
    /// ````
    /// // e.g.
    /// 1.isBetween(1,10)               // true
    /// 1.isBetween(10,1)               // true
    /// 1.isBetween(-1,1)               // true
    /// 1.isBetween(Int.min,Int.max)    // true
    ///
    /// 1.isBetween(0,0)                // false
    /// 250.isBetween(0,-1              // false
    func isBetween(_ first: Int, _ second: Int) -> Bool {
        
        if second < first { return isBetween(second, first) }
        
        return first <= self && self <= second
        
    }
    
}

// MARK: - Ordinals
public extension Int {
    
    /// Returns a `Bool` indicating if `self` is between 11 and 19
    var isTeen: Bool {
        
        let last2 = self % 100
        
        return 10 < last2 && last2 < 20
        
    }
    
    var isEven: Bool { self % 2 == 0 }
    var isOdd: Bool { !isEven }
    
    var ordinal: String {
        
        if self.isTeen {
        
            return "th"
            
        } else {
            
            switch self % 10 {
                
            case 1: return "st"
                
            case 2: return "nd"
                
            case 3: return "rd"
                
            default: return "th" //0,4,5,6,7,8,9
                
            }
            
        }
        
    }
    
    var oridinalDescription: String {
        "\(self)\(ordinal)"
    }
}

// MARK: - Roman Numerals
public extension Int {
    
    static let unhandledRomanNumeral = "Unhandled Roman Numeral"
    
    static let handledRomanNumeralRange = 1...3999
    
    /// Converts integers from 0-3999 to a string representation of the roman numeral equivalent.
    fileprivate static var romanNumerals: [Int: String] = [0: "",
                                                           1: "I",
                                                           2: "II",
                                                           3: "III",
                                                           4: "IV",
                                                           5: "V",
                                                           6: "VI",
                                                           7: "VII",
                                                           8: "VIII",
                                                           9: "IX",
                                                           
                                                           10: "X",
                                                           20: "XX",
                                                           30: "XXX",
                                                           40: "XL",
                                                           50: "L",
                                                           60: "LX",
                                                           70: "LXX",
                                                           80: "LXXX",
                                                           90: "XC",
                                                           
                                                           100: "C",
                                                           200: "CC",
                                                           300: "CCC",
                                                           400: "CD",
                                                           500: "D",
                                                           600: "DC",
                                                           700: "DCC",
                                                           800: "DCCC",
                                                           900: "CM",
                                                           
                                                           1000: "M",
                                                           2000: "MM",
                                                           3000: "MMM"]

    // ~= works like (0...5).contains()
    /// Returns a bool indicating whether the Int is within the range handled by the roman numeral generator.
    var romanNumerizable: Bool { Int.handledRomanNumeralRange ~= self }
    
    /// Returns a string representation of the integer value as a Roman numeral
    var romanNumeral: String {
        
        // Validate input
        if !Int.handledRomanNumeralRange.contains(self) {
            return Int.unhandledRomanNumeral /*EXIT*/
        }
        
        var intVal  = self
        var romVal  = ""
        var x       = 1.0
        
        while intVal > 0 {
            let digit = intVal % Int(pow(10, x))
            
            romVal = Int.romanNumerals[digit]! + romVal
            intVal = intVal - digit
            
            x += 1.0
        }
        
        return romVal
        
    }
}

// MARK: - String Formatting
public extension Int {
    
    var binary: String { String(self, radix: 2) }
    
    var delimited: String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value:self))!
        
    }
    
}

// MARK: - Base 26
public extension Int {
    
    /// Returns a base 26 string representation of this `Int`
    /// 
    /// # Example #
    /// ```swift
    ///     // e.g.
    ///     0.base26Strint  == "A"
    ///     26.base26String == "AA"
    ///     702.base26String == "AAA"
    /// ```
    ///
    /// - note: see String.base26StringToInt for converting back to Int
    var base26String: String {
        
        assert(self >= 0)
        
        var result: String = ""
        
        var num = self + 1
        
          while (num > 0) {
            num -= 1;
            
            let remainder = num % 26;
            let digit = UnicodeScalar(remainder + 97)!;
            let char: Character = Character(digit)
                        
            result.insert(char, at: result.startIndex)
            
            num = (num - remainder) / 26;
            
          }
        
        return result.uppercased();
        
    }
    
}
