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
    
    func testSize() {
        
        let q = Queue<String>(from: ["Aaron", "Beatrix", "Lee", "Scratch", "Steve", "Winston"])
        
        XCTAssert(q.count == 6)
        q.dequeue()
        XCTAssert(q.count == 5)
        q.dequeue()
        q.dequeue()
        XCTAssert(q.count == 3)
        q.dequeue()
        q.dequeue()
        XCTAssert(q.count == 1)
        q.dequeue()
        XCTAssert(q.count == 0)
        q.dequeue()
        XCTAssert(q.count == 0)
        
        print("\(#function) Successful!")
        
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
        
        print("\(#function) Successful!")
        
    }
    
}
