//
//  File.swift
//  
//
//  Created by Aaron Nance on 12/14/22.
//

import Foundation

//
//  Bundle.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 12/6/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import XCTest
import Foundation
import APNUtil

class QueueTests: XCTestCase {
    
    private let strings = ["Aaron", "Beatrix", "Lee", "Scratch", "Steve", "Winston"]
    
    func testEmptyQueue() {
        
        let emptyQueue = Queue<Int>()
        
        for _ in emptyQueue { XCTAssert(false, "Shouldn't be here..") }
        emptyQueue.forEach { XCTAssertNil($0, "Shouldn't be here..") }
        
        XCTAssertFalse(emptyQueue.contains(1), "Shouldn't contain 1")
        XCTAssert(emptyQueue.isEmpty, "should be but isn't empty")
        
        XCTAssert(emptyQueue.count == 0)
        XCTAssert(emptyQueue.peek() == nil)
        XCTAssert(emptyQueue.dequeue() == nil)
        
    }
    
    func testIsEmpty() {
        
        let full = Queue<String>(from: strings)
        let empty = Queue<String>()
        
        XCTAssertFalse(full.isEmpty, "Names is empty but shouldn't be.")
        XCTAssert(empty.isEmpty, "Names is empty but shouldn't be.")
        
    }
        
    func testIteration() {
        
        let names = Queue<String>(from: strings)
        
        XCTAssert(names.contains(strings[1]),
                  "names should but does not contain \"\(strings[1])\"")
        
        XCTAssert(names.count == strings.count,
                  "names.count == \(names.count), should ==\(strings.count)")
                
        for (i, name) in names.enumerated() {
            
            XCTAssert(name == strings[i],
                      "\"\(name)\" != \"\(strings[i])\"")
            
        }
        
        XCTAssert(names.count == 6,
                  "names.count == \(names.count), should == \(strings.count)")
        
    }
    
    func testCount() {
        
        let has6 = Queue<String>(from: strings)
        
        XCTAssert(has6.count == 6)
        has6.dequeue()
        XCTAssert(has6.count == 5)
        has6.dequeue()
        has6.dequeue()
        XCTAssert(has6.count == 3)
        has6.dequeue()
        has6.dequeue()
        XCTAssert(has6.count == 1)
        has6.dequeue()
        XCTAssert(has6.count == 0)
        XCTAssert(has6.isEmpty)
        has6.dequeue()
        XCTAssert(has6.count == 0)
        XCTAssert(has6.isEmpty)
        
        let has0 = Queue<String>()
        XCTAssert(has0.count == 0, "Count should be 0 but is \(has0.count)")
        XCTAssert(has0.isEmpty, "Should be but isn't empty")
        
    }
    
    func testEnDeQueue() {
        
        let q = Queue<Int>()
        
        q.enqueue(item: 1)
        q.enqueue(item: 2)
        q.enqueue(item: 3)
        
        XCTAssert(q.peek() == 1)
        XCTAssert(q.dequeue() == 1)
        
        XCTAssert(q.peek() == 2)
        XCTAssert(q.dequeue() == 2)
        
        q.enqueue(item: 5)
        
        XCTAssert(q.peek() == 3)
        XCTAssert(q.dequeue() == 3)
        
        XCTAssert(q.peek() == 5)
        XCTAssert(q.dequeue() == 5)
        
        XCTAssert(q.dequeue() == nil)
        
    }
    
}
