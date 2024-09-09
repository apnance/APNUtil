//
//  AttributedString.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/24/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest
import Foundation
import APNUtil

@available(iOS 15, *)
class AttributedStringTests: XCTestCase {
    
    
    func testNSAttributedStringAddition() {
        
        let final   = NSAttributedString(string: "RedGreenBlue")
        let rg      = NSAttributedString(string: "Red") + NSAttributedString(string: "Green")
        let rgb     = rg + NSAttributedString(string: "Blue")
        
        XCTAssert(rgb == final)
        
    }
    
    func test_asNSAS() {
        
        XCTAssert(AttributedString("Original").asNSAS == NSAttributedString("Original"))
        
    }
    
    func testString() {
        
        let original = "Original"
        
        XCTAssert(AttributedString(original).string == original)
        XCTAssert(AttributedString("Original").string == original)
        XCTAssertFalse(AttributedString("Fake").string == original)
        
    }
    
    
    func testIsEmpty() {
        
        let empty = ""
        
        XCTAssert(AttributedString(empty).isEmpty)
        XCTAssert(AttributedString("").isEmpty)
        
    }
    
    func testTrimLeadingNewLines() {
        
        var original = AttributedString("\n\nZipZapZoppp")
        var trimmed  = AttributedString("ZipZapZoppp")
        XCTAssertFalse(original == trimmed)
        
        original.trimLeadingNewlines()
        XCTAssert(original == AttributedString("ZipZapZoppp"))
        XCTAssert(original == trimmed)
        
    }
    
    func testTrimLeading() {
        
        var original = AttributedString("\n\nZipZapZoppp")
        var trimmed  = AttributedString("ZipZapZoppp")
        XCTAssertFalse(original == trimmed)
        
        original.trimLeading("\\")
        XCTAssertFalse(original == trimmed)
        XCTAssert(original == AttributedString("\n\nZipZapZoppp"))
        
        original.trimLeading("\n")
        XCTAssert(original == trimmed)
        
        original    = AttributedString("zzXXXabc")
        trimmed     = AttributedString("abc")
        XCTAssertFalse(original == trimmed)
        
        original.trimLeading("z")
        XCTAssertFalse(original == trimmed)
        XCTAssert(original == AttributedString("XXXabc"))
        
        original.trimLeading("X")
        XCTAssert(original == trimmed)
        
    }    
    
    func testTrimTrailing() {
        
        var original = AttributedString("ZipZapZoppp\n\n")
        var trimmed  = AttributedString("ZipZapZoppp")
        XCTAssertFalse(original == trimmed)
        
        original.trimTrailing("\\")
        XCTAssertFalse(original == trimmed)
        XCTAssert(original == AttributedString("ZipZapZoppp\n\n"))
        
        original.trimTrailing("\n")
        XCTAssert(original == trimmed)
        
        original    = AttributedString("abcXXXzz")
        trimmed     = AttributedString("abc")
        XCTAssertFalse(original == trimmed)
        
        original.trimTrailing("z")
        XCTAssertFalse(original == trimmed)
        XCTAssert(original == AttributedString("abcXXX"))
        
        original.trimTrailing("X")
        XCTAssert(original == trimmed)
        
    }
    
    func testString_asAS() {
        
        let original    = "Original"
        let final       = AttributedString(original)
        
        XCTAssert(original.asAS == final)
        
    }
}

