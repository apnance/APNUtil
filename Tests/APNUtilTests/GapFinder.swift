//
//  GapFinder.swift
//  
//
//  Created by Aaron Nance on 7/2/24.
//

import XCTest
import APNUtil

final class GapFinderTests: XCTestCase {
    
    func testFindGapsStrideUnsortedArray() {
        
        func echo(_ stride: Int, _ array: [Int], _ range: ClosedRange<Int>) {
            print("""
                     -----
                    [array:\(array)\tstride:\(stride)\trange:\(range)]
                    \(array.describeGaps(stride: stride, inRange: range))\
                     - - -
                    """)
        }
        
        var stride      = 1
        var array       = [5,4,2,1]
        var range       = 1...3
        var expected    = [Gap(3,3,stride: stride)]
        var actual = [Gap]()
        
        for _ in 0...10 {
            array.shuffle()
            actual      = array.findGaps(stride: stride, inRange: range)
            XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
            echo(stride, array, range)
            
        }
            
        stride      = 3
        array       = [0,9,-3,6,3]
        range       = -9...9
        expected    = [Gap(-9,-6,stride: stride)]
        
        for _ in 0...10 {
            array.shuffle()
            actual      = array.findGaps(stride: stride, inRange: range)
            XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
            echo(stride, array, range)
            
        }
        
    }
    
    func testFindGapsStride() {
        
        func echo(_ stride: Int, _ array: [Int], _ range: ClosedRange<Int>) {
            print("""
                     -----
                    [array:\(array)\tstride:\(stride)\trange:\(range)]
                    \(array.describeGaps(stride: stride, inRange: range))\
                     - - -
                    """)
        }
        
        // STRIDE 1
        var stride      = 1
        var array       = [1,2,4,5]
        var range       = 1...3
        var expected    = [Gap(3,3,stride: stride)]
        var actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
        array       = [2,4,6]
        range       = 2...6
        expected    = [Gap(3,3,stride: stride),Gap(5,5,stride: stride)]
        actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
        // STRIDE 2
        stride      = 2
        array       = [2,4,6]
        range       = 2...6
        expected    = []
        actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
        array       = [0,2,4,6]
        range       = 2...4
        expected    = []
        actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
        array       = [0,2,4,6]
        range       = 2...20
        expected    = [Gap(8,20,stride: stride)]
        actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
        // STRIDE 3
        stride      = 3
        array       = [1,4,7]
        range       = 1...7
        expected    = []
        actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
        array       = [3,6,9]
        range       = 0...12
        expected    = [Gap(0,0,stride: stride), Gap(12,12,stride: stride)]
        actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
        array       = [0,3,6,9]
        range       = 0...81
        expected    = [Gap(12,81,stride: stride)]
        actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
        array       = [0,3,6,9]
        range       = -3...81
        expected    = [Gap(-3,-3,stride: stride), Gap(12,81,stride: stride)]
        actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
        array       = [-3,0,3,6,9]
        range       = -9...9
        expected    = [Gap(-9,-6,stride: stride)]
        actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
        array       = [0]
        range       = -9...9
        expected    = [Gap(-9,-3,stride: stride), Gap(3,9,stride: stride)]
        actual      = array.findGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range)
        
    }
    
    func testDescribeGapsWithStrideUnsortedArray() {
        
        func echo(_ stride: Int, _ array: [Int], _ range: ClosedRange<Int>, _ expected: String, _ actual: String) {
            
            print("""
                    ---------
                    [array:\(array)\tstride:\(stride)\trange:\(range)]
                    - - - - -
                    Expected:
                    \(expected)
                    
                    Actual:
                    \(actual)
                    - - - - -
                    """)
            
        }
        
        // STRIDE 1
        // covered extensively below in other describeGapTests
        
        // STRIDE 2
        var stride      = 2
        var array       = [0,2,4,6].shuffled()
        var range       = 2...20
        var expected    = """
                        ┌────┐
                        │  2 │
                        │  ⇣ │
                        │  6 │
                        └────┘
                           8  \n\
                           ⇣  \n\
                          20  \n\
                        
                        """
        var actual      = "--Fill--"
        
        for _ in 0...10 {
            
            array.shuffle()
            actual      = array.describeGaps(stride: stride, inRange: range)
            echo(stride, array, range, expected, actual)
            XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
            
        }
        
        
        // STRIDE 3
        stride      = 3
        array       = [1,4,7]
        range       = 1...7
        expected    = Gap.noneFound
        actual      = array.describeGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range, expected, actual)
        
        array       = [3,6,9]
        range       = 0...12
        expected    = """
                       0  \n\
                    ┌────┐
                    │  3 │
                    │  ⇣ │
                    │  9 │
                    └────┘
                      12  \n\
                    
                    """
        
        for _ in 0...10 {
            
            array.shuffle()
            actual      = array.describeGaps(stride: stride, inRange: range)
            echo(stride, array, range, expected, actual)
            XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
            
        }
        
        array       = [0,3,6,9]
        range       = 0...81
        expected    = """
                    ┌────┐
                    │  0 │
                    │  ⇣ │
                    │  9 │
                    └────┘
                      12  \n\
                       ⇣  \n\
                      81  \n\
                    
                    """
        
        for _ in 0...10 {
            
            array.shuffle()
            actual      = array.describeGaps(stride: stride, inRange: range)
            echo(stride, array, range, expected, actual)
            XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
            
        }
        
        array       = [0,3,6,9]
        range       = -3...81
        expected    = """
                      -3  \n\
                    ┌────┐
                    │  0 │
                    │  ⇣ │
                    │  9 │
                    └────┘
                      12  \n\
                       ⇣  \n\
                      81  \n\
                    
                    """
        
        for _ in 0...10 {
            
            array.shuffle()
            actual      = array.describeGaps(stride: stride, inRange: range)
            echo(stride, array, range, expected, actual)
            XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
            
        }
        
        array       = [-3,0,3,6,9]
        range       = -9...9
        expected    = """
                      -9  \n\
                       ⇣  \n\
                      -6  \n\
                    ┌────┐
                    │ -3 │
                    │  ⇣ │
                    │  9 │
                    └────┘
                    
                    """
        for _ in 0...10 {
            
            array.shuffle()
            actual      = array.describeGaps(stride: stride, inRange: range)
            echo(stride, array, range, expected, actual)
            XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
            
        }
        
        array       = [0]
        range       = -9...9
        expected    = """
                      -9  \n\
                       ⇣  \n\
                      -3  \n\
                    ┌────┐
                    │  0 │
                    └────┘
                       3  \n\
                       ⇣  \n\
                       9  \n\
                    
                    """
        for _ in 0...10 {
            
            array.shuffle()
            actual      = array.describeGaps(stride: stride, inRange: range)
            echo(stride, array, range, expected, actual)
            XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
            
        }
        
        array       = [3,9,27]
        range       = -9...42
        expected    = """
                      -9  \n\
                       ⇣  \n\
                       0  \n\
                    ┌────┐
                    │  3 │
                    └────┘
                       6  \n\
                    ┌────┐
                    │  9 │
                    └────┘
                      12  \n\
                       ⇣  \n\
                      24  \n\
                    ┌────┐
                    │ 27 │
                    └────┘
                      30  \n\
                       ⇣  \n\
                      42  \n\
                    
                    """
        for _ in 0...10 {
            
            array.shuffle()
            actual      = array.describeGaps(stride: stride, inRange: range)
            echo(stride, array, range, expected, actual)
            XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
            
        }
        
    }
    
    func testDescribeGapsWithStride() {
        
        func echo(_ stride: Int, _ array: [Int], _ range: ClosedRange<Int>, _ expected: String, _ actual: String) {
            
            print("""
                    ---------
                    [array:\(array)\tstride:\(stride)\trange:\(range)]
                    - - - - -
                    Expected:
                    \(expected)
                    
                    Actual:
                    \(actual)
                    - - - - -
                    """)
            
        }
        
        // STRIDE 1
        // covered extensively below in other describeGapTests
        
        // STRIDE 2
        var stride      = 2
        var array       = [0,2,4,6]
        var range       = 2...20
        var expected    = """
                        ┌────┐
                        │  2 │
                        │  ⇣ │
                        │  6 │
                        └────┘
                           8  \n\
                           ⇣  \n\
                          20  \n\
                        
                        """
        var actual      = array.describeGaps(stride: stride, inRange: range)
        echo(stride, array, range, expected, actual)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        // STRIDE 3
        stride      = 3
        array       = [1,4,7]
        range       = 1...7
        expected    = Gap.noneFound
        actual      = array.describeGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range, expected, actual)
        
        array       = [3,6,9]
        range       = 0...12
        expected    = """
                       0  \n\
                    ┌────┐
                    │  3 │
                    │  ⇣ │
                    │  9 │
                    └────┘
                      12  \n\
                    
                    """
        actual      = array.describeGaps(stride: stride, inRange: range)
        echo(stride, array, range, expected, actual)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [0,3,6,9]
        range       = 0...81
        expected    = """
                    ┌────┐
                    │  0 │
                    │  ⇣ │
                    │  9 │
                    └────┘
                      12  \n\
                       ⇣  \n\
                      81  \n\
                    
                    """
        
        actual      = array.describeGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range, expected, actual)
        
        array       = [0,3,6,9]
        range       = -3...81
        expected    = """
                      -3  \n\
                    ┌────┐
                    │  0 │
                    │  ⇣ │
                    │  9 │
                    └────┘
                      12  \n\
                       ⇣  \n\
                      81  \n\
                    
                    """
        
        actual      = array.describeGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range, expected, actual)
        
        array       = [-3,0,3,6,9]
        range       = -9...9
        expected    = """
                      -9  \n\
                       ⇣  \n\
                      -6  \n\
                    ┌────┐
                    │ -3 │
                    │  ⇣ │
                    │  9 │
                    └────┘
                    
                    """
        actual      = array.describeGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range, expected, actual)
        
        array       = [0]
        range       = -9...9
        expected    = """
                      -9  \n\
                       ⇣  \n\
                      -3  \n\
                    ┌────┐
                    │  0 │
                    └────┘
                       3  \n\
                       ⇣  \n\
                       9  \n\
                    
                    """
        actual      = array.describeGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range, expected, actual)
        
        array       = [3,9,27]
        range       = -9...42
        expected    = """
                      -9  \n\
                       ⇣  \n\
                       0  \n\
                    ┌────┐
                    │  3 │
                    └────┘
                       6  \n\
                    ┌────┐
                    │  9 │
                    └────┘
                      12  \n\
                       ⇣  \n\
                      24  \n\
                    ┌────┐
                    │ 27 │
                    └────┘
                      30  \n\
                       ⇣  \n\
                      42  \n\
                    
                    """
        actual      = array.describeGaps(stride: stride, inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        echo(stride, array, range, expected, actual)
        
    }
    
    func testBuggy1() {
        let array       = [1,2,4,5]
        let range       = 1...3
        
        let actual      = array.describeGaps(inRange: range)
        
        let expected    = """
                            ┌───┐
                            │ 1 │
                            │ ⇣ │
                            │ 2 │
                            └───┘
                              3  \n\
                            
                            """
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
    }
    
    func testBuggy2() {
        
        let array       = [1,2,3]
        let range       = 4...20
        let expected    = [Gap(4, 20,stride: 1)]
        let actual      = array.findGaps(inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
    }
    
    func testBuggyDescribeGaps() {
        
        let array       = [1,2,4,5]
        let range       = 1...5
        let actual      = array.describeGaps(inRange: range)
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
        var actual      = array.describeGaps(inRange: range)
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
        actual      = array.describeGaps(inRange: range)
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
        
        actual      = array.describeGaps(inRange: range)
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
  
        actual      = array.describeGaps(inRange: range)
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
        
        actual      = array.describeGaps(inRange: range)
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
        
        actual      = array.describeGaps(inRange: range)
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
        
        actual      = array.describeGaps()
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
        actual      = array.describeGaps(inRange: range)
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
        
        actual      = array.describeGaps()
        expected    = Gap.noneFound
        
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,4,5]
        range       = 1...5
        actual      = array.describeGaps()
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
        
        var actual      = array.describeGaps(inRange: range)
        var expected    = Gap.noneFound
        
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,4,5]
        range       = 1...5
        actual      = array.describeGaps(inRange: range)
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
        actual      = array.describeGaps()
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
        actual      = array.describeGaps(inRange: range)
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
        actual      = array.describeGaps()
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
        actual      = array.describeGaps(inRange: range)
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
        actual      = array.describeGaps()
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
        actual      = array.describeGaps()
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
    
    
    func testCompactDescribeGapsWithStride() {
        
        func compact(_ array: [Int], _ stride: Int, _ range: ClosedRange<Int>) -> String {
            
            let compact = array.describeGaps(stride: stride,
                                             inRange: range,
                                             compactFormat: true)
            
            print("""
                    ---------
                    [array:\(array)\tstride:\(stride)\trange:\(range)]
                    - - - - -
                    \(compact)
                    ---------
                    
                    """)
            
            return compact
            
        }
        
        // Stride 1 (tested extensively elsewhere)
        var stride      = 1
        var array       = [1,2,3,4,5]
        var range       = 1...4
        var actual      = ""
        var expected    = ""
        
        // Stride 2
        stride      = 2
        array       = [0]
        range       = 0...34
        actual      = compact(array, stride, range)
        expected    =   """
                        Gaps:
                        [   2  ]  ← 17 →  [  34  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        range       = -102...100
        actual      = compact(array, stride, range)
        expected    =   """
                        Gaps:
                        [  -102 ]   ← 51 →  [   -2  ]
                        [   2   ]   ← 50 →  [  100  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [-200,-4,0,20,22]
        range       = -20...20
        actual      = compact(array, stride, range)
        expected    =   """
                        Gaps:
                        [  -20 ]   ← 8 →  [  -6  ]
                        [  -2  ]
                        [   2  ]   ← 9 →  [  18  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        range       = -200...200
        actual      = compact(array, stride, range)
        expected    =   """
                        Gaps:
                        [  -198 ]   ← 97 →  [   -6  ]
                        [   -2  ]
                        [   2   ]   ← 9 →   [   18  ]
                        [   24  ]   ← 89 →  [  200  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [-8,-4,-2,0,2,4,6,8]
        range       = 0...0
        actual      = compact(array, stride, range)
        
        expected    =   ""
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        range       = 0...8
        actual      = compact(array, stride, range)
        
        expected    =   ""
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        range       = -8...20
        actual      = compact(array, stride, range)
        expected    =   """
                        Gaps:
                        [  -6  ]
                        [  10  ]   ← 6 →  [  20  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        // Stride 3
        stride      = 3
        array       = [0]
        range       = 0...0
        actual      = compact(array, stride, range)
        expected    =   ""
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [0]
        range       = -12...0
        actual      = compact(array, stride, range)
        expected    =   """
                        Gaps:
                        [ -12 ]  ← 4 →  [  -3 ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [-33,-3]
        range       = -39...33
        actual      = compact(array, stride, range)
        expected    =   """
                        Gaps:
                        [  -39 ]   ← 2 →  [  -36 ]
                        [  -30 ]   ← 9 →  [  -6  ]
                        [   0  ]  ← 12 →  [  33  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [0,33]
        range       = 0...0
        actual      = compact(array, stride, range)
        expected    =   ""
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")

        range       = 6...300
        actual      = compact(array, stride, range)

        expected    =   """
                        Gaps:
                        [   6   ]   ← 9 →   [   30  ]
                        [   36  ]   ← 89 →  [  300  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [-10,-4,-1,2,5,8,11,14,32,35,41,47]
        range       = -4...14
        actual      = compact(array, stride, range)
        expected    =   ""
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        range       = -301...302
        actual      = compact(array, stride, range)
        
        expected    =   """
                        Gaps:
                        [  -301 ]   ← 97 →  [  -13  ]
                        [   -7  ]
                        [   17  ]   ← 5 →   [   29  ]
                        [   38  ]
                        [   44  ]
                        [   50  ]   ← 85 →  [  302  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")

        array.append(305)
        array.append(317)
        range       = -301...317
        actual      = compact(array, stride, range)
        
        expected    =   """
                        Gaps:
                        [  -301 ]   ← 97 →  [  -13  ]
                        [   -7  ]
                        [   17  ]   ← 5 →   [   29  ]
                        [   38  ]
                        [   44  ]
                        [   50  ]   ← 85 →  [  302  ]
                        [  308  ]   ← 3 →   [  314  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
    }
    
    func testCompactDescribeGaps() {
        
        var array       = [1,2,3,4,5]
        var range       = 1...4
        
        var actual      = array.describeGaps(compactFormat: true)
        var expected    = ""
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,4,5]
        range       = 1...5
        actual      = array.describeGaps(inRange: range,
                                         compactFormat: true)
        expected    = """
                        Gaps:
                        [  2  ]  ← 2 →  [  3  ]
                        
                        """
        
        XCTAssert(expected == actual, "Expected:\n\(expected)<<<\n---\nActual:\n\(actual)<<<")
        
        array       = [1,2,5]
        range       = 1...5
        actual      = array.describeGaps(inRange: range,
                                         compactFormat: true)
        expected    =  """
                        Gaps:
                        [  3  ]  ← 2 →  [  4  ]
                        
                        """
        
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [2,3,4,5]
        range       = 1...4
        actual      = array.describeGaps(inRange: range,
                                         compactFormat: true)
        expected    =   """
                            Gaps:
                            [  1  ]
                            
                            """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [1,2,5]
        range       = 1...5
        actual      = array.describeGaps(inRange: range,
                                         compactFormat: true)
        expected    =  """
                        Gaps:
                        [  3  ]  ← 2 →  [  4  ]
                        
                        """
        XCTAssert(expected == actual, "Expected:\n\(expected)\n---\nActual:\n\(actual)")
        
        array       = [4,5,6,7,8,9,25,26,27,30,35]
        range       = 1...35
        actual      = array.describeGaps(inRange: range,
                                         compactFormat: true)
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
        actual      = array.describeGaps(inRange: range,
                                         compactFormat: true)
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
        actual      = array.describeGaps(inRange: range,
                                         compactFormat: true)
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
        
        var stride      = 1
        var array       = [1,2,3,4,5]
        var range       = 1...4
        var expected    = emptyGapArray
        var actual      = array.findGaps(inRange: range)
        
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array = [1,4,5]
        range = 1...4
        expected = [Gap(2, 3,stride: stride)]
        actual      = array.findGaps(inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,2,3]
        range       = 0...3
        expected    = [Gap(0, 0,stride: stride)]
        actual      = array.findGaps(inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,2,3]
        range       = 1...2
        expected    = emptyGapArray
        actual      = array.findGaps(inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,2,3]
        range       = 1...3
        expected    = emptyGapArray
        actual      = array.findGaps(inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,2,3]
        range       = 4...20
        expected    = [Gap(4, 20,stride: stride)]
        actual      = array.findGaps(inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,2,3]
        range       = 1...20
        expected    = [Gap(4, 20,stride: stride)]
        actual      = array.findGaps(inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [1,2,3]
        range       = -10...0
        expected    = [Gap(-10, 0,stride: stride)]
        actual      = array.findGaps(inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [5,6,10,11,12,13,14,20,21,22]
        range       = 1...30
        expected    = [Gap(1, 4,stride: stride),
                        Gap(7,9,stride: stride),
                        Gap(15,19,stride: stride),
                        Gap(23,30,stride: stride)]
        
        actual      = array.findGaps(inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
        array       = [5,6,10,11,12,13,14,20,21,22]
        range       = -5...30
        expected    = [Gap(-5, 4,stride: stride),
                       Gap(7,9,stride: stride),
                       Gap(15,19,stride: stride),
                       Gap(23,30,stride: stride)]
        actual      = array.findGaps(inRange: range)
        XCTAssert(expected == actual, "Expected:\n\(expected) - Actual:\n\(actual)")
        
    }
    
}

final class GapTests: XCTestCase {
    
    func testGap() {
        let stride = 1
        var gap1 = Gap(1, 2,stride: stride)
        var gap2 = Gap(1, 2,stride: stride)
        var expectedGapSize1 = 2
        var expectedGapSize2 = 2
        XCTAssert(gap1 == gap2, "Expected \(gap1) == \(gap2)")
        
        XCTAssert(gap1.size == gap2.size)
        XCTAssert(gap1.size == expectedGapSize1, "Expected: \(expectedGapSize1) - Actual:\n\(gap1.size)")
        XCTAssert(gap2.size == expectedGapSize2, "Expected: \(expectedGapSize2) - Actual:\n\(gap2.size)")
        
        gap1 = Gap(1, 2,stride: stride)
        gap2 = Gap(1, 5,stride: stride)
        expectedGapSize1 = 2
        expectedGapSize2 = 5
        XCTAssert(gap1 != gap2, "Expected \(gap1) != \(gap2)")
        XCTAssert(gap1.size == expectedGapSize1, "Expected: \(expectedGapSize1) - Actual:\n\(gap1.size)")
        XCTAssert(gap2.size == expectedGapSize2, "Expected: \(expectedGapSize2) - Actual:\n\(gap2.size)")
        
        gap1 = Gap(-2, 2,stride: stride)
        gap2 = Gap(-2, 5,stride: stride)
        expectedGapSize1 = 5
        expectedGapSize2 = 8
        XCTAssert(gap1 != gap2, "Expected \(gap1) != \(gap2)")
        XCTAssert(gap1.size == expectedGapSize1, "Expected: \(expectedGapSize1) - Actual:\n\(gap1.size)")
        XCTAssert(gap2.size == expectedGapSize2, "Expected: \(expectedGapSize2) - Actual:\n\(gap2.size)")
        
    }
    
}
