//
//  Int.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 8/27/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class IntTests: XCTestCase {

    func testDouble() {
        
        XCTAssert(1.double == 1.0)
        XCTAssert(0.double == 0.0)
        XCTAssert(1.double.int.double == 1.0)
        
    }
    
    func testIsEven() {
        
        let odds    = [-2001, -12345, -3, -1, 1, 3, 5,1234567]
        let evens   = [-2002, -123456, -2, 0, 2, 16, 32,123456]
        
        odds.forEach{ XCTAssertFalse($0.isEven, "\($0) is even!") }
        odds.forEach{ XCTAssert(($0 + 1).isEven, "\($0) is even!") }
        evens.forEach{ XCTAssert($0.isEven,     "\($0) is *not* even!") }
        evens.forEach{ XCTAssertFalse(($0 + 1).isEven, "\($0) is *not* even!") }
    }
    
    func testIsOdd() {
        
        let odds    = [-2001, -12345, -3, -1, 1, 3, 5,1234567]
        let evens   = [-2002, -123456, -2, 0, 2, 16, 32,123456]
        
        odds.forEach{ XCTAssert($0.isOdd, "\($0) is odd!") }
        odds.forEach{ XCTAssertFalse(($0 + 1).isOdd, "\($0) is *not* odd!") }
        evens.forEach{ XCTAssertFalse($0.isOdd, "\($0) is *not* odd!") }
        evens.forEach{ XCTAssert(($0 + 1).isOdd, "\($0) is odd!") }
        
    }
    
    
    
    func testIsPrime() {
        
        let primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
        let nonPrimes = [0,1,4,6,8,9,12,25,121,202]
        
        for prime in primes { XCTAssert(prime.isPrime, "\(prime) was considered non-prime") }
        for non in nonPrimes { XCTAssertFalse(non.isPrime, "\(non) was considered prime") }
        
    }
    
    func testIntegralConcatenationOperator() {
        
        var anInt = 0
        var expected = 0
        
        anInt <+ 0
        expected = 0
        XCTAssert(anInt == expected, "Expected: \(expected) - Actual: \(anInt)")
        
        anInt <+ 5
        expected = 5
        XCTAssert(anInt == expected, "Expected: \(expected) - Actual: \(anInt)")
        
        anInt <+ 100
        expected = 5100
        XCTAssert(anInt == expected, "Expected: \(expected) - Actual: \(anInt)")
        
        anInt <+ 5
        expected = 51005
        XCTAssert(anInt == expected, "Expected: \(expected) - Actual: \(anInt)")
        
        anInt <+ 0
        expected = 510050
        XCTAssert(anInt == expected, "Expected: \(expected) - Actual: \(anInt)")
        
    }
    
    func testRomanNumerals() {
        
        // Convertible to RN
        (1...3999).forEach{ XCTAssert($0.romanNumerizable) }
        
        // Not Convertible to RN
        (-11...0).forEach{ XCTAssertFalse($0.romanNumerizable) }
        (4000...4011).forEach{ XCTAssertFalse($0.romanNumerizable) }
        
        let toTest: [Int : String] = [1 :       "I",
                                      10 :      "X",
                                      19 :      "XIX",
                                      54 :      "LIV",
                                      663:      "DCLXIII",
                                      999:      "CMXCIX",
                                      3333 :    "MMMCCCXXXIII",
                                      3999 :    "MMMCMXCIX" ]
        
        for (toConvert, expected) in toTest {
            
            XCTAssert(toConvert.romanNumeral == expected, "Expected: \(expected) - Actual: \(toConvert.romanNumeral)")
            
        }
        
    }
    
    func testBase26String() {
        
        let idToAlpha: [Int:String] = [0: "A", 1: "B", 25: "Z",
                                       26: "AA", 27 : "AB", 51 : "AZ", 52 : "BA",
                                       702 : "AAA", 703 : "AAB" ]
        
        for n in 0...10000 {
            
            let alpha = n.base26String
            
            print("\(n):\t\(alpha)")
            
        }
        
        for (n, alpha) in idToAlpha {
            
            let actual = n.base26String
            
            print("\(n) => \(alpha)")
            
            XCTAssert(actual == alpha, "ID: \(n), Expected Alpha: \(alpha) - Actual: \(actual)")
            
        }
        
    }
 
    func testOrdinal() {
        assert(1.ordinal == "st")
        assert(2.ordinal == "nd")
        assert(3.ordinal == "rd")
        assert(4.ordinal == "th")
        assert(5.ordinal == "th")
        assert(6.ordinal == "th")
        assert(7.ordinal == "th")
        assert(8.ordinal == "th")
        assert(9.ordinal == "th")
        assert(10.ordinal == "th")
        assert(11.ordinal == "th")
        assert(12.ordinal == "th")
        assert(13.ordinal == "th")
        assert(14.ordinal == "th")
        assert(15.ordinal == "th")
        assert(16.ordinal == "th")
        assert(17.ordinal == "th")
        assert(18.ordinal == "th")
        assert(19.ordinal == "th")
        assert(20.ordinal == "th")
        assert(21.ordinal == "st")
        assert(22.ordinal == "nd")
        assert(23.ordinal == "rd")
        assert(24.ordinal == "th")
        assert(25.ordinal == "th")
        assert(26.ordinal == "th")
        assert(27.ordinal == "th")
        assert(28.ordinal == "th")
        assert(29.ordinal == "th")
        assert(30.ordinal == "th")
        assert(31.ordinal == "st")
        assert(32.ordinal == "nd")
        assert(33.ordinal == "rd")
        assert(34.ordinal == "th")
        assert(35.ordinal == "th")
        assert(36.ordinal == "th")
        assert(37.ordinal == "th")
        assert(38.ordinal == "th")
        assert(39.ordinal == "th")
        assert(40.ordinal == "th")
        assert(41.ordinal == "st")
        assert(42.ordinal == "nd")
        assert(43.ordinal == "rd")
        assert(44.ordinal == "th")
        assert(45.ordinal == "th")
        assert(46.ordinal == "th")
        assert(47.ordinal == "th")
        assert(48.ordinal == "th")
        assert(49.ordinal == "th")
        assert(50.ordinal == "th")
        assert(51.ordinal == "st")
        assert(52.ordinal == "nd")
        assert(53.ordinal == "rd")
        assert(54.ordinal == "th")
        assert(55.ordinal == "th")
        assert(56.ordinal == "th")
        assert(57.ordinal == "th")
        assert(58.ordinal == "th")
        assert(59.ordinal == "th")
        assert(60.ordinal == "th")
        assert(61.ordinal == "st")
        assert(62.ordinal == "nd")
        assert(63.ordinal == "rd")
        assert(64.ordinal == "th")
        assert(65.ordinal == "th")
        assert(66.ordinal == "th")
        assert(67.ordinal == "th")
        assert(68.ordinal == "th")
        assert(69.ordinal == "th")
        assert(70.ordinal == "th")
        assert(71.ordinal == "st")
        assert(72.ordinal == "nd")
        assert(73.ordinal == "rd")
        assert(74.ordinal == "th")
        assert(75.ordinal == "th")
        assert(76.ordinal == "th")
        assert(77.ordinal == "th")
        assert(78.ordinal == "th")
        assert(79.ordinal == "th")
        assert(80.ordinal == "th")
        assert(81.ordinal == "st")
        assert(82.ordinal == "nd")
        assert(83.ordinal == "rd")
        assert(84.ordinal == "th")
        assert(85.ordinal == "th")
        assert(86.ordinal == "th")
        assert(87.ordinal == "th")
        assert(88.ordinal == "th")
        assert(89.ordinal == "th")
        assert(90.ordinal == "th")
        assert(91.ordinal == "st")
        assert(92.ordinal == "nd")
        assert(93.ordinal == "rd")
        assert(94.ordinal == "th")
        assert(95.ordinal == "th")
        assert(96.ordinal == "th")
        assert(97.ordinal == "th")
        assert(98.ordinal == "th")
        assert(99.ordinal == "th")
        assert(100.ordinal == "th")
        assert(101.ordinal == "st")
        assert(102.ordinal == "nd")
        assert(103.ordinal == "rd")
        assert(104.ordinal == "th")
        assert(105.ordinal == "th")
        assert(106.ordinal == "th")
        assert(107.ordinal == "th")
        assert(108.ordinal == "th")
        assert(109.ordinal == "th")
        assert(110.ordinal == "th")
        assert(111.ordinal == "th")
        assert(112.ordinal == "th")
        assert(113.ordinal == "th")
        assert(114.ordinal == "th")
        assert(115.ordinal == "th")
        assert(116.ordinal == "th")
        assert(117.ordinal == "th")
        assert(118.ordinal == "th")
        assert(119.ordinal == "th")
        assert(120.ordinal == "th")
        assert(121.ordinal == "st")
        assert(122.ordinal == "nd")
        assert(123.ordinal == "rd")
        assert(124.ordinal == "th")
        assert(125.ordinal == "th")
        assert(126.ordinal == "th")
        assert(127.ordinal == "th")
        assert(128.ordinal == "th")
        assert(129.ordinal == "th")
        assert(130.ordinal == "th")
    }
    
    func testFactorial() {
        
        XCTAssert(1.factorial() == 1)
        XCTAssert(2.factorial() == 2)
        XCTAssert(3.factorial() == 6)
        XCTAssert(4.factorial() == 24)
        XCTAssert(5.factorial() == 120)
        XCTAssert(6.factorial() == 720)
        XCTAssert(7.factorial() == 5040)
        
    }
    
}

