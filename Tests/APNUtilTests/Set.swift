//
//  Set.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/28/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class SetTests: XCTestCase {
    
    func testClean() {
        
        let dirty = Set([" ReD " , " GR E  E N" , "Blue"])
        var clean = dirty
        
        XCTAssert(clean == dirty)
        
        print("\nBefore:\n-----\n\(clean)")
        clean.clean(String.lowerNoSpaces)
        print("After:\n-----\n\(clean)\n")
        
        XCTAssert(clean != dirty)
        
        for item in dirty { XCTAssertFalse(clean.contains(item)) }
        
        XCTAssert(clean.contains("red"))
        XCTAssert(clean.contains("green"))
        XCTAssert(clean.contains("blue"))
        
    }
    
}
