//
//  String.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/28/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class StringTests: XCTestCase {
    
    func testSnip() {
        
        var text = ""
        var n = 0
        var snipped = text.snip(n)
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        XCTAssert(snipped == "")
        
        n = 1000
        snipped = text.snip(n)
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        XCTAssert(snipped == "")
        
        text = "123456"
        n = 1
        snipped = text.snip()
        XCTAssert(snipped == "12345")
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        
        n = 2
        snipped = text.snip(2)
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        XCTAssert(snipped == "1234")
        
        n = text.count
        snipped = text.snip(n)
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        XCTAssert(snipped == "")
        
        n = text.count + 10
        snipped = text.snip(n)
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        XCTAssert(snipped == "")
        
    }
    
    func testShuck() {
        
        var text = ""
        var n = 0
        var shucked = text.shuck(n)
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        XCTAssert(shucked == "")
        
        n = 1000
        shucked = text.shuck(n)
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        XCTAssert(shucked == "")
        
        text = "[ABCBA]"
        
        shucked = text.shuck()
        XCTAssert(shucked == "ABCBA")
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        
        n = 2
        shucked = text.shuck(n)
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        XCTAssert(shucked == "BCB", "shucked should == \"\" but equals \(shucked)")
        
        n = text.count
        shucked = text.shuck(n)
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        XCTAssert(shucked == "")
        
        n = text.count + 10
        shucked = text.shuck(n)
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        XCTAssert(shucked == "")
        
        text = "BEA"
        n = 1
        shucked = text.shuck(n)
        XCTAssert(shucked == "E")
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        
        
        text = "BEA"
        n = 2
        shucked = text.shuck(n)
        XCTAssert(shucked == "")
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        
        text = "BEA"
        n = 10
        shucked = text.shuck(n)
        XCTAssert(shucked == "")
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        
        XCTAssert("HuskCornHusk".shuck(4) == "Corn", "\("HuskCornfHusk".shuck(4))")
        
        XCTAssert("[shuck me]".shuck() == "shuck me", "\("[shuck me]".shuck())")
        
    }
    
    func testProcessed() {
        
        let test1 = " BlAh BLAH"
        var working = test1
        XCTAssert(working == test1)
        
        working = working.processed({ $0.uppercased() })
        XCTAssert(working == " BLAH BLAH")
        
        working = test1
        XCTAssert(working == test1)
        
        working = working.processed({ $0.lowercased() })
        XCTAssert(working == " blah blah")
        
        working = test1
        XCTAssert(working == test1)
        
        working = working.processed( String.lowerNoSpaces )
        XCTAssert(working == "blahblah")
        
    }
    
    func testLeftPadding() {
        
        // 10
        let zonk = "Zonk"
        let zonkLeftPadded10 = zonk.leftPadded(toLength: 10, withPad: " ")
        print("|\(zonkLeftPadded10)|")
        XCTAssert(zonkLeftPadded10 == "      \(zonk)")
        
        // 3
        let zonkLeftPadded3 = zonk.leftPadded(toLength: 3, withPad: " ")
        print("|\(zonkLeftPadded3)|")
        XCTAssert(zonkLeftPadded3 == "onk")
        
        // 0
        let zonkLeftPadded0 = zonk.leftPadded(toLength: 0, withPad: " ")
        print("|\(zonkLeftPadded0)|")
        XCTAssert(zonkLeftPadded0 == "")
        
    }
    
    func testRightPadding() {
        
        // 10
        let zonk = "Zonk"
        let zonkRightPadded10 = zonk.rightPadded(toLength: 10, withPad: " ")
        print("|\(zonkRightPadded10)|")
        XCTAssert(zonkRightPadded10 == "\(zonk)      ")
        
        // 3
        let zonkRightPadded3 = zonk.rightPadded(toLength: 3, withPad: " ")
        print("|\(zonkRightPadded3)|")
        XCTAssert(zonkRightPadded3 == "Zon")
        
        // 0
        let zonkRightPadded0 = zonk.rightPadded(toLength: 0, withPad: " ")
        print("|\(zonkRightPadded0)|")
        XCTAssert(zonkRightPadded0 == "")
        
    }
    
    func testCenterPadding() {
        
        // 13
        let test = "123456789"
        var len = 13
        let testCenterPadded13 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(testCenterPadded13)|")
        XCTAssert(testCenterPadded13 == "  \(test)  ")
        
        // 12
        len = 12
        let testCenterPadded12 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(testCenterPadded12)|")
        XCTAssert(testCenterPadded12 == "  \(test) ")
        
        
        // 10
        len = 10
        let testCenterPadded10 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(testCenterPadded10)|")
        XCTAssert(testCenterPadded10 == " \(test)")
        
        // 8
        len = 8
        let testCenterPadded8 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(testCenterPadded8)|")
        XCTAssert(testCenterPadded8 == "12345678")
        
        // 7
        len = 7
        let testCenterPadded7 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(testCenterPadded7)|")
        XCTAssert(testCenterPadded7 == "2345678")
        
        // 1
        len = 1
        let zonkCenterPadded1 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(zonkCenterPadded1)|")
        XCTAssert(zonkCenterPadded1 == "5")
        
        // 0
        len = 0
        let zonkCenterPadded0 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(zonkCenterPadded0)|")
        XCTAssert(zonkCenterPadded0 == "")
        
    }
    
    func testBase26StringToInt() {
        
        var expected    = 0
        var actual      = "A".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        expected        = 1
        actual          = "B".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        expected        = 25
        actual          = "Z".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        expected        = 26
        actual          = "AA".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        expected        = 52
        actual          = "BA".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        expected        = 702
        actual          = "AAA".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        XCTAssertNil("AB1".base26StringToInt)
        XCTAssertNil("1AB".base26StringToInt)
        XCTAssertNil("A123".base26StringToInt)
        
        // Casing
        XCTAssert("A".base26StringToInt == "a".base26StringToInt)
        XCTAssert("B".base26StringToInt == "b".base26StringToInt)
        XCTAssert("AAA".base26StringToInt == "aaa".base26StringToInt)
        
        // Upper
        for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            
            let str = String(char)
            XCTAssertNotNil(str.base26StringToInt,
                            "\"\(str)\".base26StringToInt returned nil value")
            
        }
        
        // Lower
        for char in "abcdefghijklmnopqrstuvwxyz" {
            
            let str = String(char)
            XCTAssertNotNil(str.base26StringToInt,
                            "\"\(str)\".base26StringToInt returned nil value")
            
        }
        
        // Nils
        for char in "123456789!@#$%^&*() _+:'[]\\/" {
            
            let str = String(char)
            XCTAssertNil(str.base26StringToInt,
                         "\"\(str)\".base26StringToInt returned non-nil value")
            
        }
        
    }
    
}
