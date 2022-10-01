//
//  FixedHeightStack.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/24/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class FixedHeightStackTests: XCTestCase {
    
    let s1 = "Pip"
    let s2 = "Steve"
    let s3 = "Winston"
    
    let i1 = 1
    let i2 = 10
    let i3 = -20
    let i4 = Int.min
    
    func testBasicsX() {
        
        // Array Initializer
        var a1 = APNUtil.FixedHeightStack(maxHeight: 2, [s1, s2, s3])
                
        XCTAssert(a1.pop() == s3)
        XCTAssert(a1.pop() == s2)
        XCTAssertNil(a1.pop())
        
        a1.push(s3)
        a1.push(s2)
        a1.push(s1)
        XCTAssert(a1.pop()  == s1)
        XCTAssert(a1.pop()  == s2)
        XCTAssertNil(a1.peek())
        
        // Variadic Initializer
        var a2 = APNUtil.FixedHeightStack<Int>(maxHeight: 2, [i1,i2,i3,i4])
        
        XCTAssert(a2.pop() == i4)
        XCTAssert(a2.pop() == i3)
        XCTAssertNil(a2.peek())
        
        a2.push(i2)
        XCTAssert(a2.peek() == i2)
        a2.push(i3)
        a2.push(i4)
        XCTAssert(a2.count == 2)
        XCTAssert(a2.pop() == i4)
        
        XCTAssert(a2.pop() == i3)
        XCTAssertNil(a2.peek())
        XCTAssertNil(a2.popPeek())
        XCTAssertNil(a2.pop())
        
        var a3 = APNUtil.FixedHeightStack<Int>(maxHeight: 4)
        a3.push(i4)
        a3.push(i3)
        a3.push(i2)
        a3.push(i1)
        a3.push(i3)
        a3.push(i2)
        XCTAssert(a3.count == 4)
        
        XCTAssert(a3.pop() == i2)
        XCTAssert(a3.pop() == i3)
        XCTAssert(a3.pop() == i1)
        XCTAssert(a3.pop() == i2)
        
        XCTAssert(a2.count == 0)
        XCTAssertNil(a2.peek())
        XCTAssertNil(a2.popPeek())
        XCTAssertNil(a2.pop())
        
    }
    
    func testPushNew() {
        
        var a1 = APNUtil.FixedHeightStack<Int>(maxHeight: 4)
        
        a1.pushNew(i4)
        a1.pushNew(i3)
        a1.pushNew(i3)
        XCTAssert(a1.count == 2)
        XCTAssert(a1.pop() == i3)
        
        a1.pushNew(i4)
        XCTAssert(a1.count == 1)
        XCTAssert(a1.pop() == i4)
        
    }
    
}
