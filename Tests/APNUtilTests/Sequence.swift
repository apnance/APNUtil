//
//  Sequence.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 11/17/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

import XCTest
import Foundation
import APNUtil

class SequenceTests: XCTestCase {
    
    // MARK: - Sequence<AdditiveArithmetic>
    func testSum() {
        
        var testArray = [0,1,2,3]
        XCTAssert(testArray.sum() == 6)
        
        testArray = [0,0,0,0]
        XCTAssert(testArray.sum() == 0)
        
        testArray = [-1,0,1]
        XCTAssert(testArray.sum() == 0)
        
        testArray = [-2,-1,0]
        XCTAssert(testArray.sum() == -3)
        
        testArray = []
        XCTAssert(testArray.sum() == 0)
        
        var testArrayDouble: [Double] = [0,1,2,3]
        XCTAssert(testArrayDouble.sum() == 6.0)
        
        testArrayDouble = [0,0,0,0]
        XCTAssert(testArrayDouble.sum() == 0.0)
        
        testArrayDouble = [-1,0,1]
        XCTAssert(testArrayDouble.sum() == 0.0)
        
        testArrayDouble = [-2,-1,0]
        XCTAssert(testArrayDouble.sum() == -3.0, "Expected: -3.0 :: Actual: \(testArrayDouble.sum())")
        
        testArrayDouble = []
        XCTAssert(testArrayDouble.sum() == 0.0)
     
    }
    
}
