//
//  GapFinder.swift
//  
//
//  Created by Aaron Nance on 7/2/24.
//

import XCTest
import APNUtil

final class GapFinderTests: XCTestCase {
    
    func testBuggyDescribeGaps() {
        
        let array       = [1,2,4,5]
        let range       = 1...5
        
        let actual      = GapFinder.describeGaps(in: array, usingRange: range)
        let expected    = """
                            ┌───┐
                            │ 1 │
                            │ ⇣ │
                            │ 2 │
                            └───┘
                              3  \n\
                            ┌───┐
                            │ 4 │
                            │ ⇣ │
                            │ 5 │
                            └───┘\n
                            """
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
    }
    
    func testDescribeGaps1() {
        
        var array       = [1,2,4,5]
        var range       = 1...3
        
        var actual      = GapFinder.describeGaps(in: array, usingRange: range)
        var expected    = """
                            ┌───┐
                            │ 1 │
                            │ ⇣ │
                            │ 2 │
                            └───┘
                              3  \n\
                            
                            """
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1]
        range       = 1...4
        
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    = """
                            ┌───┐
                            │ 1 │
                            └───┘
                              2  \n\
                              ⇣  \n\
                              4  \n\
                            
                            """
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
                
        array       = [3]
        range       = 1...5
        
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    = """
                              1  \n\
                              ⇣  \n\
                              2  \n\
                            ┌───┐
                            │ 3 │
                            └───┘
                              4  \n\
                              ⇣  \n\
                              5  \n\
                            
                            """
        
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
                
        array       = [3,4]
        range       = 1...5
        
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    = """
                              1  \n\
                              ⇣  \n\
                              2  \n\
                            ┌───┐
                            │ 3 │
                            │ ⇣ │
                            │ 4 │
                            └───┘
                              5  \n\
                            
                            """
        
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [3,4]
        range       = 1...4
        
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    = """
                              1  \n\
                              ⇣  \n\
                              2  \n\
                            ┌───┐
                            │ 3 │
                            │ ⇣ │
                            │ 4 │
                            └───┘\n
                            """
        
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [3,4]
        range       = 1...3
        
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    = """
                              1  \n\
                              ⇣  \n\
                              2  \n\
                            ┌───┐
                            │ 3 │
                            └───┘\n
                            """
        
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,2,4,5]
        range       = 1...5
        
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    = """
                            ┌───┐
                            │ 1 │
                            │ ⇣ │
                            │ 2 │
                            └───┘
                              3  \n\
                            ┌───┐
                            │ 4 │
                            │ ⇣ │
                            │ 5 │
                            └───┘\n
                            """
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,4,5]
        range       = 1...5
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    =   """
                        ┌───┐
                        │ 1 │
                        └───┘
                          2  \n\
                          ⇣  \n\
                          3  \n\
                        ┌───┐
                        │ 4 │
                        │ ⇣ │
                        │ 5 │
                        └───┘\n
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [1,2,3,4,5]
        range       = 1...4
        
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    = GapFinder.noneFound
        
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,4,5]
        range       = 1...5
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    =   """
                        ┌───┐
                        │ 1 │
                        └───┘
                          2  \n\
                          ⇣  \n\
                          3  \n\
                        ┌───┐
                        │ 4 │
                        │ ⇣ │
                        │ 5 │
                        └───┘\n
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
    }
    
    func testDescribeGaps2() {
        
        var array       = [1,2,3,4,5]
        var range       = 1...4
        
        var actual      = GapFinder.describeGaps(in: array, usingRange: range)
        var expected    = GapFinder.noneFound
        
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,4,5]
        range       = 1...5
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    =   """
                        ┌───┐
                        │ 1 │
                        └───┘
                          2  \n\
                          ⇣  \n\
                          3  \n\
                        ┌───┐
                        │ 4 │
                        │ ⇣ │
                        │ 5 │
                        └───┘\n
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [1,2,5]
        range       = 1...5
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    =   """
                        ┌───┐
                        │ 1 │
                        │ ⇣ │
                        │ 2 │
                        └───┘
                          3  \n\
                          ⇣  \n\
                          4  \n\
                        ┌───┐
                        │ 5 │
                        └───┘\n
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [2,3,4,5]
        range       = 1...4
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    =   """
                          1  \n\
                        ┌───┐
                        │ 2 │
                        │ ⇣ │
                        │ 4 │
                        └───┘\n
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [1,2,5]
        range       = 1...5
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    =   """
                        ┌───┐
                        │ 1 │
                        │ ⇣ │
                        │ 2 │
                        └───┘
                          3  \n\
                          ⇣  \n\
                          4  \n\
                        ┌───┐
                        │ 5 │
                        └───┘\n
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [4,5,6,7,8,9,25,26,27,30,35]
        range       = 1...35
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    =   """
                           1  \n\
                           ⇣  \n\
                           3  \n\
                        ┌────┐
                        │  4 │
                        │  ⇣ │
                        │  9 │
                        └────┘
                          10  \n\
                           ⇣  \n\
                          24  \n\
                        ┌────┐
                        │ 25 │
                        │  ⇣ │
                        │ 27 │
                        └────┘
                          28  \n\
                           ⇣  \n\
                          29  \n\
                        ┌────┐
                        │ 30 │
                        └────┘
                          31  \n\
                           ⇣  \n\
                          34  \n\
                        ┌────┐
                        │ 35 │
                        └────┘\n
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [1,4,5,6,7,8,9,25,26,27,30,35]
        range       = 1...35
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    =   """
                        ┌────┐
                        │  1 │
                        └────┘
                           2  \n\
                           ⇣  \n\
                           3  \n\
                        ┌────┐
                        │  4 │
                        │  ⇣ │
                        │  9 │
                        └────┘
                          10  \n\
                           ⇣  \n\
                          24  \n\
                        ┌────┐
                        │ 25 │
                        │  ⇣ │
                        │ 27 │
                        └────┘
                          28  \n\
                           ⇣  \n\
                          29  \n\
                        ┌────┐
                        │ 30 │
                        └────┘
                          31  \n\
                           ⇣  \n\
                          34  \n\
                        ┌────┐
                        │ 35 │
                        └────┘\n
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [1,4,5,6,7,8,9,25,26,27,30,33,34,35]
        range       = 1...35
        actual      = GapFinder.describeGaps(in: array, usingRange: range)
        expected    =   """
                        ┌────┐
                        │  1 │
                        └────┘
                           2  \n\
                           ⇣  \n\
                           3  \n\
                        ┌────┐
                        │  4 │
                        │  ⇣ │
                        │  9 │
                        └────┘
                          10  \n\
                           ⇣  \n\
                          24  \n\
                        ┌────┐
                        │ 25 │
                        │  ⇣ │
                        │ 27 │
                        └────┘
                          28  \n\
                           ⇣  \n\
                          29  \n\
                        ┌────┐
                        │ 30 │
                        └────┘
                          31  \n\
                           ⇣  \n\
                          32  \n\
                        ┌────┐
                        │ 33 │
                        │  ⇣ │
                        │ 35 │
                        └────┘\n
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
    }
    
    func testCompactDescribeGaps() {
        
        var array       = [1,2,3,4,5]
        var range       = 1...4
        
        var actual      = GapFinder.compactDescribeGaps(in: array, usingRange: range)
        var expected    = ""
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,4,5]
        range       = 1...5
        actual      = GapFinder.compactDescribeGaps(in: array, usingRange: range)
        expected    = """
                        Gaps:
                        [  2  ]  ← 2 →  [  3  ]
                        
                        """
        
        XCTAssert(expected == actual, "Expected:\n\(expected)<<<\n---\nActual:\n\(actual)<<<")
        
        array       = [1,2,5]
        range       = 1...5
        actual      = GapFinder.compactDescribeGaps(in: array, usingRange: range)
        expected    =  """
                        Gaps:
                        [  3  ]  ← 2 →  [  4  ]
                        
                        """
        
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [2,3,4,5]
        range       = 1...4
        actual      = GapFinder.compactDescribeGaps(in: array, usingRange: range)
        expected    =   """
                            Gaps:
                            [  1  ]
                            
                            """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [1,2,5]
        range       = 1...5
        actual      = GapFinder.compactDescribeGaps(in: array, usingRange: range)
        expected    =  """
                        Gaps:
                        [  3  ]  ← 2 →  [  4  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [4,5,6,7,8,9,25,26,27,30,35]
        range       = 1...35
        actual      = GapFinder.compactDescribeGaps(in: array, usingRange: range)
        expected    =   """
                        Gaps:
                        [   1  ]   ← 3 →  [   3  ]
                        [  10  ]  ← 15 →  [  24  ]
                        [  28  ]   ← 2 →  [  29  ]
                        [  31  ]   ← 4 →  [  34  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [1,4,5,6,7,8,9,25,26,27,30,35]
        range       = 1...35
        actual      = GapFinder.compactDescribeGaps(in: array, usingRange: range)
        expected    =   """
                        Gaps:
                        [   2  ]   ← 2 →  [   3  ]
                        [  10  ]  ← 15 →  [  24  ]
                        [  28  ]   ← 2 →  [  29  ]
                        [  31  ]   ← 4 →  [  34  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [1,4,5,6,7,8,9,25,26,27,30,33,34,35]
        range       = 1...35
        actual      = GapFinder.compactDescribeGaps(in: array, usingRange: range)
        expected    =   """
                        Gaps:
                        [   2  ]   ← 2 →  [   3  ]
                        [  10  ]  ← 15 →  [  24  ]
                        [  28  ]   ← 2 →  [  29  ]
                        [  31  ]   ← 2 →  [  32  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
    }
    
    func testFind() throws {
        
        let emptyGapArray = [Gap]()
        
        var array       = [1,2,3,4,5]
        var range       = 1...4
        var expected    = emptyGapArray
        var actual      = GapFinder.find(in: array,
                                         usingRange: range)
        
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array = [1,4,5]
        range = 1...4
        expected = [Gap(2, 3)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array = [1,2,3]
        range = 0...3
        expected = [Gap(0, 0)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array = [1,2,3]
        range = 1...2
        expected = emptyGapArray
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array = [1,2,3]
        range = 1...3
        expected = emptyGapArray
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array = [1,2,3]
        range = 4...20
        expected = [Gap(4, 20)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array = [1,2,3]
        range = 1...20
        expected = [Gap(4, 20)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array = [1,2,3]
        range = -10...0
        expected = [Gap(-10, 0)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array = [5,6,10,11,12,13,14,20,21,22]
        range = 1...30
        expected = [Gap(1, 4),
                    Gap(7,9),
                    Gap(15,19),
                    Gap(23,30)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array = [5,6,10,11,12,13,14,20,21,22]
        range = -5...30
        expected = [Gap(-5, 4),
                    Gap(7,9),
                    Gap(15,19),
                    Gap(23,30)]
        actual = GapFinder.find(in: array,
                                usingRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
    }
}

final class GapTests: XCTestCase {
    
    func testGap() {
        
        var gap1 = Gap(1, 2)
        var gap2 = Gap(1, 2)
        var expectedGapSize1 = 2
        var expectedGapSize2 = 2
        XCTAssert(gap1 == gap2, "Expected \(gap1) == \(gap2)")
        
        XCTAssert(gap1.size == gap2.size)
        XCTAssert(gap1.size == expectedGapSize1, "Expected: \(expectedGapSize1) - Actual:\n\(gap1.size)")
        XCTAssert(gap2.size == expectedGapSize2, "Expected: \(expectedGapSize2) - Actual:\n\(gap2.size)")
        
        gap1 = Gap(1, 2)
        gap2 = Gap(1, 5)
        expectedGapSize1 = 2
        expectedGapSize2 = 5
        XCTAssert(gap1 != gap2, "Expected \(gap1) != \(gap2)")
        XCTAssert(gap1.size == expectedGapSize1, "Expected: \(expectedGapSize1) - Actual:\n\(gap1.size)")
        XCTAssert(gap2.size == expectedGapSize2, "Expected: \(expectedGapSize2) - Actual:\n\(gap2.size)")
        
        gap1 = Gap(-2, 2)
        gap2 = Gap(-2, 5)
        expectedGapSize1 = 5
        expectedGapSize2 = 8
        XCTAssert(gap1 != gap2, "Expected \(gap1) != \(gap2)")
        XCTAssert(gap1.size == expectedGapSize1, "Expected: \(expectedGapSize1) - Actual:\n\(gap1.size)")
        XCTAssert(gap2.size == expectedGapSize2, "Expected: \(expectedGapSize2) - Actual:\n\(gap2.size)")
        
    }
    
}
