//
//  Operators.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 12/14/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class OperatorsTests: XCTestCase {
    
    func testRandomFromRangeOperator() {
        
        var actual = Set<Int>()
        let expected: Set<Int> = [1,2,3,4,5,6,7,8,9,10]
        let iters = 200
        
        for _ in 0...iters {
            
            actual.insert(1.?.10)
            
        }
        
        XCTAssert(actual == expected)
        
        print("""
                    
                    Testing: 1.?.10 @\(iters) iterations
                    Results: \(actual.sorted()) == \(expected.sorted())
                    
                """)
        
    }
    
    func testIntegralConcatenationOperator() {
        
        // Postive Numbers
        var num = 1
        var expected = 13
        
        num <+ 3
        expected = 13
        XCTAssert(num == expected, "Expected: \(expected) - Actual: \(num)")
        
        num <+ 5
        expected = 135
        XCTAssert(num == expected, "Expected: \(expected) - Actual: \(num)")
        
        num <+ 10
        expected = 13510
        XCTAssert(num == expected, "Expected: \(expected) - Actual: \(num)")
        
        num <+ 999
        expected = 13510999
        XCTAssert(num == expected, "Expected: \(expected) - Actual: \(num)")
        
        // Negative Numbers
        num = -1
        num <+ 3
        expected = -13
        XCTAssert(num == expected, "Expected: \(expected) - Actual: \(num)")
        
        num <+ 5
        expected = -135
        XCTAssert(num == expected, "Expected: \(expected) - Actual: \(num)")
        
        num <+ 10
        expected = -13510
        XCTAssert(num == expected, "Expected: \(expected) - Actual: \(num)")
        
        num <+ 999
        expected = -13510999
        XCTAssert(num == expected, "Expected: \(expected) - Actual: \(num)")
        
    }
    
}
