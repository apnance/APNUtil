//
//  LinkedList.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 11/7/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

import XCTest
import APNUtil

class LinkedListTests: XCTestCase {

    func testInit() {
        
        // Test init()
        var list    = LinkedList<Int>()
        XCTAssert(list.peekFirst()  == nil)
        XCTAssert(list.peekLast()   == nil)

        // Test init(T)
        let int     = 1279
        list        = LinkedList<Int>(int)
        
        XCTAssert(list.peekFirst()  == int)
        XCTAssert(list.peekLast()   == int)
        
        // Test init([T])
        let intVals = [1,2,3,4,5,6,7,1,2,7,9]
        list = LinkedList<Int>(intVals)
        
        for val in intVals {
            
            let removed = list.removeFirst()
            
            XCTAssert(val == removed)
            
            let comparison = val == removed ? "==" : "!="
            print("Array:\t\(intVals)\nLList:\t \(list)\n\(val) \(comparison) \(removed!)\n")
            
        }
        
        let strVals = ["First", "Second", "Third", "Fourth", "Sixth", "Last"]
        let list2 = LinkedList<String>(strVals)
        
        for val in strVals {
            
            let removed = list2.removeFirst()
            
            XCTAssert(val == removed)
            
            let comparison = val == removed ? "==" : "!="
            print("Array:\t\(strVals)\nLList:\t \(list2)\n\(val) \(comparison) \(removed!)\n")
            
        }
        
    }
    
    func testAddFirst() {

        let list    = LinkedList<Int>()

        let int1    = 1279
        list.addFirst(int1)
        XCTAssert(list.peekFirst()  == int1)
        XCTAssert(list.peekLast()   == int1)

        let int2    = 1117
        list.addFirst(int2)
        XCTAssert(list.peekFirst()  == int2)
        XCTAssert(list.peekLast()   == int1)
        
        let int3    = 524
        list.addFirst(int3)
        XCTAssert(list.peekFirst()  == int3)
        XCTAssert(list.peekLast()   == int1)
        
    }
    
    func testAddLast() {
        
        let list    = LinkedList<Int>()

        let int1     = 1279
        list.addLast(int1)
        XCTAssert(list.peekFirst()  == int1)
        XCTAssert(list.peekLast()   == int1)

        let int2    = 1117
        list.addLast(int2)
        XCTAssert(list.peekFirst()  == int1)
        XCTAssert(list.peekLast()   == int2)

        let int3    = 524
        list.addLast(int3)
        XCTAssert(list.peekFirst()  == int1)
        XCTAssert(list.peekLast()   == int3)
        
    }
    
    func testRemoveFirst() {
        
        let list    = LinkedList<Int>()

        let int1     = 1279
        list.addLast(int1)
        XCTAssert(list.peekFirst()      == int1)
        XCTAssert(list.peekLast()       == int1)

        XCTAssert(list.removeFirst()    == int1)
        XCTAssert(list.peekFirst()      == nil)
        XCTAssert(list.peekLast()       == nil)

        list.addFirst(2)
        list.addLast(3)
        list.addFirst(1)
        list.addLast(4)
        list.addLast(5)

        XCTAssert(list.removeFirst() == 1)
        XCTAssert(list.removeFirst() == 2)
        XCTAssert(list.removeFirst() == 3)
        XCTAssert(list.removeFirst() == 4)
        XCTAssert(list.removeFirst() == 5)
        XCTAssert(list.removeFirst() == nil)
        
    }
    
    func testRemoveLast() {
        
        let list    = LinkedList<Int>()

        let int1     = 1279
        list.addLast(int1)
        XCTAssert(list.peekFirst()      == int1)
        XCTAssert(list.peekLast()       == int1)

        XCTAssert(list.removeLast()     == int1)
        XCTAssert(list.peekFirst()      == nil)
        XCTAssert(list.peekLast()       == nil)

        list.addFirst(2)
        list.addLast(3)
        list.addFirst(1)
        list.addLast(4)
        list.addLast(5)

        XCTAssert(list.removeLast() == 5, list.description)
        XCTAssert(list.removeLast() == 4, list.description)
        XCTAssert(list.removeLast() == 3, list.description)
        XCTAssert(list.removeLast() == 2, list.description)
        XCTAssert(list.removeLast() == 1, list.description)
        XCTAssert(list.removeLast() == nil)
        
        let list2   = LinkedList<String>()
        list2.addLast("Last")
        list2.addFirst("First")
        
        XCTAssert(list2.peekFirst() == "First")
        XCTAssert(list2.peekLast()  == "Last")
        
        XCTAssert(list2.removeLast() == "Last")
        XCTAssert(list2.removeLast() == "First")
        XCTAssert(list2.removeLast() == nil)
        XCTAssert(list2.removeLast() == nil)
        XCTAssert(list2.removeLast() == nil)
        
    }
    
    func testPeekFirst() {
        
        let list    = LinkedList<Int>()

        let int1     = 1279
        let int2     = 1117
        let int3     = 524
        let int4     = 9999
        
        XCTAssertNil(list.peekFirst())
        
        list.addFirst(int1)
        XCTAssert(list.peekFirst() == int1)

        list.addFirst(int2)
        XCTAssert(list.peekFirst() == int2)
        
        list.addLast(int3)
        XCTAssert(list.peekFirst() == int2)
        
        list.addLast(int4)
        XCTAssert(list.peekFirst() == int2)
        
    }
    
    func testPeekLast() {
        
        let list    = LinkedList<Int>()
        
        let int1     = 1279
        let int2     = 1117
        let int3     = 524
        let int4     = 9999
        
        XCTAssertNil(list.peekLast())
        
        list.addFirst(int1)
        XCTAssert(list.peekLast() == int1)
        
        list.addFirst(int2)
        XCTAssert(list.peekLast() == int1)
        
        list.addLast(int3)
        XCTAssert(list.peekLast() == int3)
        
        list.addFirst(int4)
        XCTAssert(list.peekLast() == int3)
        
        while list.count > 0 { list.removeFirst() }
        
        XCTAssert(list.count == 0)
        XCTAssertNil(list.peekLast())
        
    }
    
    func testCount() {
        
        var list    = LinkedList<Int>()
        XCTAssert(list.count == 0)
        
        list        = LinkedList<Int>(1)
        XCTAssert(list.count == 1)
        
        list.removeLast()
        list.removeFirst()
        
        XCTAssert(list.count == 0)
        
        var count = 10
        for _ in 1...count { list.addFirst(0) }
        
        XCTAssert(list.peekFirst() == list.peekLast())
        XCTAssert(list.count == count)
        
        list    = LinkedList<Int>()
        count   = Int.random(min: 15, max: 999)
        
        for i in 1...count {
            
            if Bool.random() { list.addFirst(i) }
            else { list.addLast(i) }
            
        }
        
        XCTAssert(list.count == count)
        
    }
    
    /// Test sequences of random add/remove/peek/count calls
    func testSequence() {
        
        for _ in 0...100 {
                        
            var list = LinkedList<Int>()
            
            let int1 = 1279
            let int2 = 1117
            let int3 = 524
            let int4 = 9999
            
            XCTAssertNil(list.peekFirst())
            XCTAssertNil(list.peekLast())
            
            list.addFirst(int1)
            XCTAssert(list.peekFirst()  == int1)
            XCTAssert(list.peekLast()   == int1)
            
            list.addLast(int2)
            XCTAssert(list.peekFirst()  == int1)
            XCTAssert(list.peekLast()   == int2)
            
            // Empty List
            for _ in 0...10 { list.removeFirst() }
            for _ in 0...10 { list.removeLast()}
            for _ in 0...10 { list.removeFirst() }
            for _ in 0...10 { list.removeLast() }
            
            while(list.peekFirst() != nil) {
                
                if Bool.random() {list.removeFirst() }
                else { list.removeLast() }
                
            }
            
            XCTAssert(list.count == 0)
            XCTAssertNil(list.peekFirst())
            XCTAssertNil(list.peekLast())
            
            // Fill List
            var randomSequenceCount = 40
            for i in 1...randomSequenceCount {
                
                if Bool.random() { list.addFirst(i) }
                else { list.addLast(i) }
                
            }
            
            XCTAssert(list.count == randomSequenceCount)
            XCTAssertNotNil(list.peekFirst())
            XCTAssertNotNil(list.peekLast())
            
            // Empty
            for _ in 1...randomSequenceCount {
                
                if Bool.random() { list.removeLast() }
                else { list.removeFirst() }
                
            }
            
            XCTAssert(list.count == 0)
            XCTAssertNil(list.peekFirst())
            XCTAssertNil(list.peekLast())
            
            list.addLast(int3)
            XCTAssert(list.peekLast()   == int3)
            
            list.addFirst(int4)
            XCTAssert(list.peekLast()   == int3)
            XCTAssert(list.peekFirst()  == int4)
            
            // Random adds/removes
            list = LinkedList<Int>()
            randomSequenceCount = Int.random(min: 33, max: 55)
            var count = 0
            for i in 1...randomSequenceCount {
                
                if Bool.random() {
                    
                    if Bool.random() { list.addFirst(i) }
                    else { list.addLast(i) }
                    
                    count += 1
                }
                else {
                    
                    if Bool.random() { if list.removeFirst() != nil { count -= 1 } }
                    else { if list.removeLast() != nil { count -= 1 } }
                    
                }
                
            }
            
            XCTAssert(list.count == count)
            if count > 0 {
                
                XCTAssertNotNil(list.peekFirst())
                XCTAssertNotNil(list.peekLast())
                
            } else {
                
                XCTAssertNil(list.peekFirst())
                XCTAssertNil(list.peekLast())
                
            }
            
        }
        
    }
    
}
