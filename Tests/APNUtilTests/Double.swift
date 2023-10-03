//
//  Double.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/24/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest

class DoubleTests: XCTestCase {
    
    func testInt() {
        
        XCTAssert(1.0.int == 1)
        XCTAssert(5.3.int == 5)
        XCTAssert(10.0.int.double.int == 10)
        
    }
    
    func testRounding() {
                
        let value = 1.12345678901
        
        (0...15).forEach{ print("\($0):\t\(value.roundTo($0))") }
        
        XCTAssert(value.roundTo(0) == 1.0)
        XCTAssert(value.roundTo(1) == 1.1)
        XCTAssert(value.roundTo(2) == 1.12)
        XCTAssert(value.roundTo(3) == 1.123)
        XCTAssert(value.roundTo(4) == 1.1235)
        XCTAssert(value.roundTo(5) == 1.12346)
        XCTAssert(value.roundTo(6) == 1.123457)
        XCTAssert(value.roundTo(7) == 1.1234568)
        XCTAssert(value.roundTo(8) == 1.12345679)
        XCTAssert(value.roundTo(9) == 1.123456789)
        XCTAssert(value.roundTo(10) == 1.123456789)
        XCTAssert(value.roundTo(11) == 1.12345678901)
        XCTAssert(value.roundTo(20) == 1.12345678901)
        
    }
    
    func testDecimalOnly() {
        
        var decimal  = 123.456789
        
        var places = 1
        var expected = 4
        XCTAssert(decimal.decimal(to:places) == expected,
                  "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
        
        for i in 1...10 {
            
            decimal += Double(i) * 2
            
            for _ in 0...50 {
                
                places = 2
                expected = 45
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                
                places = 3
                expected = 456
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                
                places = 4
                expected = 4567
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                
                places = 5
                expected = 45678
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                
                places = 6
                expected = 456789
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                
                places = 8
                expected = 45678900
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                
                places = 10
                expected = 4567890000
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                places = 12
                expected = 456789000000
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                
            }
            
        }
        
        decimal     = 0.1
        
        places      = 1
        expected    = 1
        XCTAssert(decimal.decimal(to:places) == expected,
                  "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
        
        for i in 1...10 {
            
            decimal += Double(i * 2)
            for _ in 0...20 {
                
                
                places = 2
                expected = 10
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                
                places = 3
                expected = 100
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                
                places = 10
                expected = 1000000000
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                places = 12
                expected = 100000000000
                XCTAssert(decimal.decimal(to:places) == expected,
                          "Expected: \(expected) - Actual: \(decimal.decimal(to:places))")
                
            }
            
        }
        
    }
    
}
