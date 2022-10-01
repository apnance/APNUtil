//
//  ClosedRange.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 1/5/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class ClosedRangeTests: XCTestCase {
    
    func testLowerBoundNonZero() {
        
        var closed = -1...10
        XCTAssert(closed.lowerBoundNonZero != 0)
        XCTAssert(closed.lowerBoundNonZero == -1)
        
        closed = 0...10
        XCTAssert(closed.lowerBoundNonZero != 0)
        XCTAssert(closed.lowerBoundNonZero == 1)
        
        closed = -100...(-10)
        XCTAssert(closed.lowerBoundNonZero != 0)
        XCTAssert(closed.lowerBoundNonZero == -100)
        
    }
    
    func testUpperBoundNonZero() {
        
        var closed = -10...2
        XCTAssert(closed.upperBoundNonZero != 0)
        XCTAssert(closed.upperBoundNonZero == 2)
        
        closed = -1...0
        XCTAssert(closed.upperBoundNonZero != 0)
        XCTAssert(closed.upperBoundNonZero == -1)
        
        closed = -100...10
        XCTAssert(closed.upperBoundNonZero == 10)
    
    }
    
    func testSum() {
        
        XCTAssert((-3...3).sum == 0)
        XCTAssert((0...3).sum == 6)
        XCTAssert((0...0).sum == 0)
        XCTAssert((1...5).sum == 15)
        
    }
    
    func testRepeat() {
        
        (1...3).repeat{ print("Ho") }
        
        (1...5).repeat{ print("This is #\($0)") }
        
        var sum = 0
        (1...5).repeat{ (num: Int) -> () in sum += num }
        XCTAssert(sum == (1...5).sum)
        
    }
    
}
