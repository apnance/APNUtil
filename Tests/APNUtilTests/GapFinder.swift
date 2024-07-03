//
//  GapFinder.swift
//  
//
//  Created by Aaron Nance on 7/2/24.
//

import XCTest
import APNUtil

final class GapFinderTests: XCTestCase {

    func testGapFinder() throws {
        
        let emptyGapArray = [Gap]()
        
        var array       = [1,2,3,4,5]
        var range       = 1...4
        var expected    = emptyGapArray
        var actual      = GapFinder.find(in: array,
                                         usingRange: range)
        
        XCTAssert(expected == actual, "Expected:\(expected) - Actual: \(actual)")
        
        array = [1,4,5]
        range = 1...4
        expected = [Gap(2, 3)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\(expected) - Actual: \(actual)")
        
        array = [1,2,3]
        range = 0...3
        expected = [Gap(0, 0)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\(expected) - Actual: \(actual)")
        
        array = [1,2,3]
        range = 1...2
        expected = emptyGapArray
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\(expected) - Actual: \(actual)")
        
        array = [1,2,3]
        range = 1...3
        expected = emptyGapArray
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\(expected) - Actual: \(actual)")
        
        array = [1,2,3]
        range = 4...20
        expected = [Gap(4, 20)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\(expected) - Actual: \(actual)")
        
        array = [1,2,3]
        range = 1...20
        expected = [Gap(4, 20)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\(expected) - Actual: \(actual)")
        
        array = [1,2,3]
        range = -10...0
        expected = [Gap(-10, 0)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\(expected) - Actual: \(actual)")
        
        array = [5,6,10,11,12,13,14,20,21,22]
        range = 1...30
        expected = [Gap(1, 4),
                    Gap(7,9),
                    Gap(15,19),
                    Gap(23,30)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\(expected) - Actual: \(actual)")
        
        array = [5,6,10,11,12,13,14,20,21,22]
        range = -5...30
        expected = [Gap(-5, 4),
                    Gap(7,9),
                    Gap(15,19),
                    Gap(23,30)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\(expected) - Actual: \(actual)")
        
    }

    func testGap() {
        
        var gap1 = Gap(1, 2)
        var gap2 = Gap(1, 2)
        var expectedGapSize1 = 2
        var expectedGapSize2 = 2
        XCTAssert(gap1 == gap2, "Expected \(gap1) == \(gap2)")
        
        XCTAssert(gap1.size == gap2.size)
        XCTAssert(gap1.size == expectedGapSize1, "Expected: \(expectedGapSize1) - Actual: \(gap1.size)")
        XCTAssert(gap2.size == expectedGapSize2, "Expected: \(expectedGapSize2) - Actual: \(gap2.size)")
        
        gap1 = Gap(1, 2)
        gap2 = Gap(1, 5)
        expectedGapSize1 = 2
        expectedGapSize2 = 5
        XCTAssert(gap1 != gap2, "Expected \(gap1) != \(gap2)")
        XCTAssert(gap1.size == expectedGapSize1, "Expected: \(expectedGapSize1) - Actual: \(gap1.size)")
        XCTAssert(gap2.size == expectedGapSize2, "Expected: \(expectedGapSize2) - Actual: \(gap2.size)")
        
        gap1 = Gap(-2, 2)
        gap2 = Gap(-2, 5)
        expectedGapSize1 = 5
        expectedGapSize2 = 8
        XCTAssert(gap1 != gap2, "Expected \(gap1) != \(gap2)")
        XCTAssert(gap1.size == expectedGapSize1, "Expected: \(expectedGapSize1) - Actual: \(gap1.size)")
        XCTAssert(gap2.size == expectedGapSize2, "Expected: \(expectedGapSize2) - Actual: \(gap2.size)")
        
    }
    
}
