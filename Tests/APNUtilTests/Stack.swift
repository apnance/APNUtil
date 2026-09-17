//
//  Stack.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/24/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class StackTests: XCTestCase {
    
    let s1 = "Pip"
    let s2 = "Steve"
    let s3 = "Winston"
    
    let i1 = 1
    let i2 = 10
    let i3 = -20
    let i4 = Int.min
    
    func testBasics() {
        
        // Array Initializer
        var a1 = APNUtil.Stack(with: [s1, s2, s3])
        
        XCTAssert(a1.pop() == s3)
        XCTAssert(a1.pop() == s2)
        XCTAssert(a1.pop() == s1)
        XCTAssertNil(a1.pop())
        
        a1.push(s3)
        a1.push(s2)
        a1.push(s1)
        XCTAssert(a1.pop()  == s1)
        XCTAssert(a1.pop()  == s2)
        XCTAssert(a1.peek() == s3)
        
        // Variadic Initializer
        var a2 = APNUtil.Stack(i1,i2,i3,i4)
        
        XCTAssert(a2.pop() == i4)
        XCTAssert(a2.pop() == i3)
        a2.push(i2)
        XCTAssert(a2.pop() == i2)
        XCTAssert(a2.pop() == i2)
        XCTAssert(a2.pop() == i1)
        XCTAssertNil(a2.pop())
        XCTAssertNil(a2.pop())
        XCTAssertNil(a2.pop())
        
        var a3 = APNUtil.Stack<Int>()
        a3.push(i3)
        a3.push(i2)
        a3.push(i1)
        XCTAssert(a3.pop() == i1)
        XCTAssert(a3.pop() == i2)
        XCTAssert(a3.pop() == i3)
        XCTAssertNil(a3.pop())
        
    }
    
    func testPushNew() {
        
        var a1 = APNUtil.Stack<Int>()
        
        a1.pushNew(i4)
        a1.pushNew(i3)
        a1.pushNew(i3)
        XCTAssert(a1.count == 2)
        XCTAssert(a1.pop() == i3)
        
        a1.pushNew(i4)
        XCTAssert(a1.count == 1)
        XCTAssert(a1.pop() == i4)
        
    }
    
    func testPeekFor() {
        
        // String
        var a1 = Stack<String>()
        XCTAssertFalse(a1.peekFor(s1))
        XCTAssertFalse(a1.peekFor(s2))
        XCTAssertFalse(a1.peekFor(s3))
        XCTAssertFalse(a1.peekFor(""))
        
        a1 = APNUtil.Stack(s1,s2,s3)
        XCTAssertFalse(a1.peekFor(s1))
        XCTAssertFalse(a1.peekFor(s2))
        XCTAssert(a1.peekFor(s3))       // true
        XCTAssertFalse(a1.peekFor(""))
        
        a1.pop()
        XCTAssertFalse(a1.peekFor(s1))
        XCTAssert(a1.peekFor(s2))       // true
        XCTAssertFalse(a1.peekFor(s3))
        XCTAssertFalse(a1.peekFor(""))
        
        a1.pop()
        XCTAssert(a1.peekFor(s1))       // true
        XCTAssertFalse(a1.peekFor(s2))
        XCTAssertFalse(a1.peekFor(s3))
        XCTAssertFalse(a1.peekFor(""))
        
        a1.pop()
        XCTAssertFalse(a1.peekFor(s1))
        XCTAssertFalse(a1.peekFor(s2))
        XCTAssertFalse(a1.peekFor(s3))
        XCTAssertFalse(a1.peekFor(""))
        
        // Int
        var a2 = Stack<Int>()
        XCTAssertFalse(a2.peekFor(i1))
        XCTAssertFalse(a2.peekFor(i2))
        XCTAssertFalse(a2.peekFor(i3))
        XCTAssertFalse(a2.peekFor(Int.min))
        XCTAssertFalse(a2.peekFor(Int.max))
        
        a2 = APNUtil.Stack(i1,i2,i3)
        XCTAssertFalse(a2.peekFor(i1))
        XCTAssertFalse(a2.peekFor(i2))
        XCTAssert(a2.peekFor(i3))       // true
        XCTAssertFalse(a2.peekFor(Int.min))
        XCTAssertFalse(a2.peekFor(Int.max))
        
        a2.pop()
        XCTAssertFalse(a2.peekFor(i1))
        XCTAssert(a2.peekFor(i2))       // true
        XCTAssertFalse(a2.peekFor(i3))
        XCTAssertFalse(a2.peekFor(Int.min))
        XCTAssertFalse(a2.peekFor(Int.max))
        
        a2.pop()
        XCTAssert(a2.peekFor(i1))       // true
        XCTAssertFalse(a2.peekFor(i2))
        XCTAssertFalse(a2.peekFor(i3))
        XCTAssertFalse(a2.peekFor(Int.min))
        XCTAssertFalse(a2.peekFor(Int.max))
        
        a2.pop()
        XCTAssertFalse(a2.peekFor(i1))
        XCTAssertFalse(a2.peekFor(i2))
        XCTAssertFalse(a2.peekFor(i3))
        XCTAssertFalse(a2.peekFor(Int.min))
        XCTAssertFalse(a2.peekFor(Int.max))
        
    }
    
}
