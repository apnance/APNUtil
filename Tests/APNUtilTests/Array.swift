//
//  Array.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/24/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest
import Foundation
import APNUtil

class ArrayTests: XCTestCase {
    
    var fruit = [String: Int]()
    var words = [String: Int]()
    
    override func setUp() {
        
        fruit = TestData.fruit
        words = TestData.wordsDictionary
        
    }
    
    func testLastUsableIndex() {
        
        var a1 = [Int]()
        XCTAssert(a1.lastUsableIndex == -1)
        
        a1 = [1,2,3,4,5]
        
        while a1.count > 0 {
            _ = a1.removeLast()
            
            XCTAssert(a1.lastUsableIndex == (a1.count - 1))
            
        }
        
    }
    
    func testFirstK() {
        
        var a           = [Int]()
        var k           = 10
        var expected    = [Int]()
        var actual      = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = []
        k = 0
        expected = []
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = []
        k = -1
        expected = []
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1,2]
        k = -1
        expected = []
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1,2]
        k = 0
        expected = []
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1,2]
        k = 1
        expected = [1]
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1,2]
        k = 2
        expected = [1,2]
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = 3
        expected = [1279,1017,524]
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = 2000
        expected = [1279,1017,524,-1,-2]
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = 0
        expected = []
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = 5
        expected = a
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = a.count
        expected = a
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = a.count + 10
        expected = a
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = a.count - (a.count + 10)
        expected = []
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = a.count - 1
        expected = [1279,1017,524,-1]
        actual = a.first(k: k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
    }
    
    
    func testLastK() {
        
        var a           = [Int]()
        var k           = 10
        var expected    = [Int]()
        var actual      = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = []
        k = 0
        expected = []
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = []
        k = -1
        expected = []
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1,2]
        k = -1
        expected = []
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1,2]
        k = 0
        expected = []
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1,2]
        k = 1
        expected = [2]
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1,2]
        k = 2
        expected = [1,2]
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = 3
        expected = [524,-1,-2]
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = 2000
        expected = [1279,1017,524,-1,-2]
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = 0
        expected = []
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = 5
        expected = a
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = a.count
        expected = a
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = a.count + 10
        expected = a
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = a.count - (a.count + 10)
        expected = []
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        a = [1279,1017,524,-1,-2]
        k = a.count - 1
        expected = [1017,524,-1,-2]
        actual = a.last(k)
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
    }
    
    func testSecondToLast() {
        
        // Int
        XCTAssert([0,1,2,3,4].secondToLast == 3)
        XCTAssert([2].secondToLast == nil)
        XCTAssert([Int]().secondToLast == nil)
        
        // String
        XCTAssert(["see", "hear", "speak"].secondToLast == "hear")
        XCTAssert(["see"].secondToLast == nil)
        
    }
    
    func testSecond() {
        
        // Int
        XCTAssert([0,1,2,3,4].second == 1)
        XCTAssert([2].second == nil)
        XCTAssert([Int]().second == nil)
        
        // String
        XCTAssert(["see", "hear", "speak", "no evil"].second == "hear")
        XCTAssert(["see"].second == nil)
        
    }
    
    func testCenterIndex() {
        
        XCTAssert([].centerIndex == -1)
        XCTAssert([1].centerIndex == 0)
        XCTAssert([0,1].centerIndex == 1)
        XCTAssert([0,1,2].centerIndex == 1)
        XCTAssert([0,1,2,3].centerIndex == 2)
        
        XCTAssert(["A"].centerIndex == 0)
        XCTAssert(["A","B"].centerIndex == 1)
        XCTAssert(["A","B","C"].centerIndex == 1)
        XCTAssert(["A","B","C","D"].centerIndex == 2)
        XCTAssert(["A","B","C","D","E","F"].centerIndex == 3)
        
    }

    func testCenterLeftIndex() {
        
        XCTAssert([].centerLeftIndex == -1)
        XCTAssert([1].centerLeftIndex == 0)
        XCTAssert([0,1].centerLeftIndex == 0)
        XCTAssert([0,1,2].centerLeftIndex == 1)
        XCTAssert([0,1,2,3].centerLeftIndex == 1)
        
        XCTAssert(["A"].centerLeftIndex == 0)
        XCTAssert(["A","B"].centerLeftIndex == 0)
        XCTAssert(["A","B","C"].centerLeftIndex == 1)
        XCTAssert(["A","B","C","D"].centerLeftIndex == 1)
        XCTAssert(["A","B","C","D","E","F"].centerLeftIndex == 2)
        
    }

    
    func testIsInBounds() {
        
        var a1 = [1,2,3,4,5]
        // True
        XCTAssert(a1.isInBounds(index: 0))
        XCTAssert(a1.isInBounds(index: 1))
        XCTAssert(a1.isInBounds(index: 2))
        XCTAssert(a1.isInBounds(index: 3))
        XCTAssert(a1.isInBounds(index: 4))
        
        // False
        XCTAssertFalse(a1.isInBounds(index: 5))
        XCTAssertFalse(a1.isInBounds(index: -1))
        XCTAssertFalse(a1.isInBounds(index: Int.min))
        XCTAssertFalse(a1.isInBounds(index: Int.max))
        
        a1 = []
        // False
        XCTAssertFalse(a1.isInBounds(index: 0))
        XCTAssertFalse(a1.isInBounds(index: 1))
        XCTAssertFalse(a1.isInBounds(index: 2))
        XCTAssertFalse(a1.isInBounds(index: 3))
        XCTAssertFalse(a1.isInBounds(index: 4))
        XCTAssertFalse(a1.isInBounds(index: 5))
        XCTAssertFalse(a1.isInBounds(index: -1))
        XCTAssertFalse(a1.isInBounds(index: Int.min))
        XCTAssertFalse(a1.isInBounds(index: Int.max))
        
        var a2 = ["Bea", "Lee", "Aaron", "Pip", "Win"]
        // True
        XCTAssert(a2.isInBounds(index: 0))
        XCTAssert(a2.isInBounds(index: 1))
        XCTAssert(a2.isInBounds(index: 2))
        XCTAssert(a2.isInBounds(index: 3))
        XCTAssert(a2.isInBounds(index: 4))
        
        // False
        XCTAssertFalse(a2.isInBounds(index: 5))
        XCTAssertFalse(a2.isInBounds(index: -1))
        XCTAssertFalse(a2.isInBounds(index: Int.min))
        XCTAssertFalse(a2.isInBounds(index: Int.max))
        
        a2 = []
        // False
        XCTAssertFalse(a2.isInBounds(index: 0))
        XCTAssertFalse(a2.isInBounds(index: 1))
        XCTAssertFalse(a2.isInBounds(index: 2))
        XCTAssertFalse(a2.isInBounds(index: 3))
        XCTAssertFalse(a2.isInBounds(index: 4))
        XCTAssertFalse(a2.isInBounds(index: 5))
        XCTAssertFalse(a2.isInBounds(index: -1))
        XCTAssertFalse(a2.isInBounds(index: Int.min))
        XCTAssertFalse(a2.isInBounds(index: Int.max))
        
    }
    
    func testAreInBounds() {
        
        var a1 = [1,2,3,4,5]
        // True
        XCTAssert(a1.areInBounds(indices: [0]))
        XCTAssert(a1.areInBounds(indices: [4]))
        XCTAssert(a1.areInBounds(indices: [0,4]))
        XCTAssert(a1.areInBounds(indices: [0,1,2,3,4]))
        
        // False
        XCTAssertFalse(a1.areInBounds(indices: [0,1,2,3,4,5]))
        XCTAssertFalse(a1.areInBounds(indices: [-1,0,1,2,3,4]))
        XCTAssertFalse(a1.areInBounds(indices: [Int.min]))
        XCTAssertFalse(a1.areInBounds(indices: [Int.max]))
        
        a1 = []
        // False
        XCTAssertFalse(a1.areInBounds(indices: [0]))
        XCTAssertFalse(a1.areInBounds(indices: [4]))
        XCTAssertFalse(a1.areInBounds(indices: [0,4]))
        XCTAssertFalse(a1.areInBounds(indices: [0,1,2,3,4]))
        XCTAssertFalse(a1.areInBounds(indices: [0,1,2,3,4,5]))
        XCTAssertFalse(a1.areInBounds(indices: [-1,0,1,2,3,4]))
        XCTAssertFalse(a1.areInBounds(indices: [Int.min]))
        XCTAssertFalse(a1.areInBounds(indices: [Int.max]))
        
    }
    
    func testElementPreceding() {
        
        let a1 = ["Bea", "Lee", "Aaron", "Pip", "Win"]

        // True
        XCTAssert(a1.elementPreceding(index: 1) == "Bea")
        XCTAssert(a1.elementPreceding(index: 2) == "Lee")
        XCTAssert(a1.elementPreceding(index: 3) == "Aaron")
        XCTAssert(a1.elementPreceding(index: 4) == "Pip")
        XCTAssert(a1.elementPreceding(index: 5) == "Win")
        
        // False
        XCTAssertNil(a1.elementPreceding(index: 0))
        XCTAssertNil(a1.elementPreceding(index: 6))
        XCTAssertNil(a1.elementPreceding(index: Int.min))
        XCTAssertNil(a1.elementPreceding(index: Int.max))
        
    }
    
    func testSub() {
        
        let a1 = [1,2,3,4,5,6,7]
        
        let a2 = a1.sub(start: 2,end: 2)
        XCTAssert(a2.count == 1)
        XCTAssert(a2 == [3])
        
        let a3 = a1.sub(start: 0,end: 1)
        XCTAssert(a3.count == 2)
        XCTAssert(a3 == [1,2])
        
        let a10 = ["Aaron", "Bea", "Lee", "Pip", "Winnie", "Scratch", "Steve the Frog"]
        let a11 = a10.sub(start: 0, end: 2)
        XCTAssert(a11 == ["Aaron", "Bea", "Lee"] )
        
        let a12 = a10.sub(start: a10.startIndex, end: a10.lastUsableIndex)
        XCTAssert(a12 == a10)
        
    }
    
    func testCycleBigger() {
        
        let a1 = [1,2,4,5,6,7]
        XCTAssert(a1.cycleBigger(1) == 2)
        XCTAssert(a1.cycleBigger(2) == 4)
        XCTAssert(a1.cycleBigger(6) == 7)
        XCTAssert(a1.cycleBigger(7) == 1)
        XCTAssert(a1.cycleBigger(Int.max) == a1.min())
        
        let a2 = a1.shuffled()
        XCTAssert(a2.cycleBigger(1) == 2)
        XCTAssert(a2.cycleBigger(2) == 4)
        XCTAssert(a2.cycleBigger(6) == 7)
        XCTAssert(a2.cycleBigger(7) == 1)
        XCTAssert(a2.cycleBigger(Int.max) == a2.min())
        
        let a3 = [Int]()
        XCTAssertNil(a3.cycleBigger(Int.max))
        XCTAssertNil(a3.cycleBigger(Int.min))
        XCTAssertNil(a3.cycleBigger(0))
        
    }
    
    func testCycleSmaller() {
        
        let a1 = [1,2,4,5,6,7]
        XCTAssert(a1.cycleSmaller(1) == 7)
        XCTAssert(a1.cycleSmaller(3) == 2)
        XCTAssert(a1.cycleSmaller(4) == 2)
        XCTAssert(a1.cycleSmaller(6) == 5)
        XCTAssert(a1.cycleSmaller(7) == 6)
        XCTAssert(a1.cycleSmaller(Int.min) == a1.max())
        
        let a2 = a1.shuffled()
        XCTAssert(a2.cycleSmaller(1) == 7)
        XCTAssert(a2.cycleSmaller(3) == 2)
        XCTAssert(a2.cycleSmaller(4) == 2)
        XCTAssert(a2.cycleSmaller(6) == 5)
        XCTAssert(a2.cycleSmaller(7) == 6)
        XCTAssert(a2.cycleSmaller(Int.min) == a2.max())
        
        let a3 = [Int]()
        XCTAssertNil(a3.cycleSmaller(Int.max))
        XCTAssertNil(a3.cycleSmaller(Int.min))
        XCTAssertNil(a3.cycleSmaller(0))
        
    }
    
    func testRandomElementsFromWeighted() {
        
        var results = [String: Int]()
        
        let totalIters = 1000
        
        for _ in 0...totalIters {
              
            let randoms = words.randomKeysFromWeighted(3)
            
            randoms.forEach{ results.add($0, 1) }
        
        }
        
        results.percentages(roundedTo: 2).printSimple()
        words.percentages(roundedTo: 2).printSimple()
        
    }
    
    
    private func testPermute<Element:Equatable>(_ permuted: [[Element]],
                                                shouldContain: [[Element]]?,
                                                expectedCount: Int) {
        if let shouldContain = shouldContain {
        
            for sc in shouldContain {
                
                XCTAssert(permuted.contains(sc), "Expected permuation(\(sc)) not found.")
                
            }
            
        }
        
        XCTAssert(permuted.count == expectedCount,
                  "Incorrect permuted count.  Expected: \(expectedCount) - Actual: \(permuted.count)")

        
    }
    
    func testPermute() {
        
        testPermute([1,2].permuted(),
                    shouldContain: [[1,2],[2,1]],
                    expectedCount: 2)
        
        testPermute([9,9].permuted(),
                    shouldContain: [[9,9]],
                    expectedCount: 2)
        
        testPermute([1,2,4].permuted(),
                    shouldContain: [[1,2,4], [1,4,2], [2,1,4],
                                    [2,4,1], [4,1,2], [4,2,1]],
                    expectedCount: 6)
        
        testPermute(["A","B","A"].permuted(),
                    shouldContain: [["A","B","A"],
                                    ["A","A","B"],
                                    ["B","A","A"]],
                    expectedCount: 6)
        
        for i in 1...7 {
            
            testPermute(Array(repeating: 0, count: i).permuted(),
                        shouldContain: nil,
                        expectedCount: i.factorial())
            
        }
        
        
    }
    
    func testPermuteDeduped() {
        
        testPermute([1,2].permuteDeduped(),
                    shouldContain: [[1,2],[2,1]],
                    expectedCount: 2)
        
        testPermute([9,9].permuteDeduped(),
                    shouldContain: [[9,9]],
                    expectedCount: 1)
        
        testPermute([1,2,4].permuteDeduped(),
                    shouldContain: [[1,2,4], [1,4,2], [2,1,4],
                                    [2,4,1], [4,1,2], [4,2,1]],
                    expectedCount: 6)
        
        testPermute(["A","B","A"].permuteDeduped(),
                    shouldContain: [["A","B","A"],
                                    ["A","A","B"],
                                    ["B","A","A"]],
                    expectedCount: 3)
        
    }
    
    func testPadSelfRandomly() {
        
        class TestClass: CustomStringConvertible, Copyable {
            
            func copy() -> Copyable {
                
                return TestClass(a: self.a, b: self.b)
                
            }
            
            var a: Int
            var b: String
            
            init(a: Int, b: String) { self.a = a; self.b = b }
            
            var description: String { "a:\(a) - b:\(b)" }
            
        }
        
        // reference based
        var array = [TestClass(a: 0, b: "zero"),
                     TestClass(a: 1, b: "one")]
        
        array.padSelfRandomly(finalCount: 4)
        
        for i in 0..<(array.count - 1) {
            
            let tc1 = array[i]
            
            for j in (i+1)..<array.count {
                
                let tc2 = array[j]
            
                XCTAssert(tc1 !== tc2, "\(tc1) === \(tc2)")
                
            }
            
        }
        
        // value based
        var array2 = [1,2,3,4,5]
        
        array2.padSelfRandomly(finalCount: 10)
        XCTAssert(array2.count == 10)

        var array3 = [1]
        array3.padSelfRandomly(finalCount: 5)
        array3.forEach { XCTAssert($0 == 1) }
        
    }
    
    
    func testMirror() {

        var original   = [String]()
        var mirrored    = [String]()
        
        var originalInt = [Int]()
        var mirroredInt = [Int]()
        
        // one element array
        original = ["A"]
        mirrored = original.mirror()
        print("original: \(original)\nmirrored:\(mirrored)")
        XCTAssert(original.count == mirrored.count)
        XCTAssert(mirrored == ["A"])
        
        // odd len array
        original = ["X","Y","Z"]
        mirrored = original.mirror()
        print("\noriginal: \(original)\nmirrored:\(mirrored)")
        XCTAssert(original.count == mirrored.count)
        XCTAssert(mirrored == ["X", "Y", "X"])

        originalInt = [1,2,3,4,5]
        mirroredInt = originalInt.mirror()
        print("\noriginal: \(originalInt)\nmirrored:\(mirroredInt)")
        XCTAssert(originalInt.count == mirroredInt.count)
        XCTAssert(mirroredInt == [1,2,3,2,1])
        
        // even len array
        original = ["M","N"]
        mirrored = original.mirror()
        print("\noriginal: \(original)\nmirrored:\(mirrored)")
        XCTAssert(original.count == mirrored.count)
        XCTAssert(mirrored == ["M","M"])

        originalInt = [1,2,3,4]
        mirroredInt = originalInt.mirror()
        print("\noriginal: \(originalInt)\nmirrored:\(mirroredInt)")
        XCTAssert(originalInt.count == mirroredInt.count)
        XCTAssert(mirroredInt == [1,2,2,1])

        
        // BEATRIX
        original = ["B","E","A","T","R","I","X"]
        mirrored = original.mirror()
        print("\noriginal: \(original)\nmirrored:\(mirrored)")
        XCTAssert(original.count == mirrored.count)
        
    }
    
    // MARK: - Array<String>
    func testClean() {
        
        let char0 = "Slor "
        let char1 = "Ov Ax"
        let char2 = " dUKe "
        let char3 = "Angstrom"
        
        var alfland = [char0, char1, char2, char3]
        
        XCTAssert(alfland[0] == char0)
        XCTAssert(alfland[1] == char1)
        XCTAssert(alfland[2] == char2)
        XCTAssert(alfland[3] == char3)
        
        print("\nBefore:\n-----")
        alfland.printSimple()
        
        alfland.clean(String.lowerNoSpaces)
        
        XCTAssert(alfland[0] != char0)
        XCTAssert(alfland[1] != char1)
        XCTAssert(alfland[2] != char2)
        XCTAssert(alfland[3] != char3)

        XCTAssert(alfland[0] == "slor")
        XCTAssert(alfland[1] == "ovax")
        XCTAssert(alfland[2] == "duke")
        XCTAssert(alfland[3] == "angstrom")

        print("\nAfter:\n-----")
        alfland.printSimple()
        print()

    }
    
    func testTrimmed() {
        
        let un = [" space   ",
                  "invaders   ",
                  "is fun",
                  " ! ?!  "]
        
        let proc = un.trimmed()
        
        print("Before trimmed():\t\(un)")
        print("After trimmed():\t\(proc)")
            
        XCTAssert(proc[0] == "space")
        XCTAssert(proc[1] == "invaders")
        XCTAssert(proc[2] == "is fun")
        XCTAssert(proc[3] == "! ?!")
        
    }
    
    func testUppercased() {
        
        let un = ["aaron",
                  "lE e",
                  "BEA TRIX",
                  "PiP",
                  " winnie "]
        
        let proc = un.uppercased()
        
        print("Before trimmed():\t\(un)")
        print("After trimmed():\t\(proc)")
            
        XCTAssert(proc[0] == "AARON")
        XCTAssert(proc[1] == "LE E")
        XCTAssert(proc[2] == "BEA TRIX")
        XCTAssert(proc[3] == "PIP")
        XCTAssert(proc[4] == " WINNIE ")
        
    }
    
    func testLowercased() {
        
        let un = ["aaron",
                  "lE e",
                  "BEA TRIX",
                  "PiP",
                  " winnie "
        ]
        
        let proc = un.lowercased()
        
        print("Before trimmed():\t\(un)")
        print("After trimmed():\t\(proc)")
            
        XCTAssert(proc[0] == "aaron")
        XCTAssert(proc[1] == "le e")
        XCTAssert(proc[2] == "bea trix")
        XCTAssert(proc[3] == "pip")
        XCTAssert(proc[4] == " winnie ")
        
    }
    
    func testLowerNoSpaces() {
        
        let un = ["aaron",
                  "lE e",
                  "BEA    TR  IX",
                  "PiP",
                  " winnie ",
                  "       "]
        
        let proc = un.lowerNoSpaces()
        
        print("Before trimmed():\t\(un)")
        print("After trimmed():\t\(proc)")
            
        XCTAssert(proc[0] == "aaron")
        XCTAssert(proc[1] == "lee")
        XCTAssert(proc[2] == "beatrix")
        XCTAssert(proc[3] == "pip")
        XCTAssert(proc[4] == "winnie")
        XCTAssert(proc[5] == "")
        
    }
    
    func testDeDupe() {
        
        var testArray = [1,2,2,3,3,3,4,4,4,4]
        
        testArray = testArray.dedupe()
        
        XCTAssert(testArray == [1,2,3,4])
        
    }
    
    func testAppendUnique() {
        var testArray = [1,2,3]

        
        testArray.appendUnique(1)
        testArray.appendUnique(2)
        testArray.appendUnique(3)
        testArray.appendUnique(4)
        
        XCTAssert(testArray == [1,2,3,4])
        
    }
    
    func testUniques() {
        
        XCTAssert([1,2,2,3,3,3,4,4,4,4].uniques == 4)
        XCTAssert([1,2,3].uniques == 3)
        XCTAssert(["A","a","%","1","2","%"].uniques == 5)
        
    }
    
    func testAllUniques() {
        
        // True
        XCTAssert([1,2,3,4,5].allUniques)
        XCTAssert(["a","b","c"].allUniques)
        
        // False
        XCTAssertFalse([1,1,2,3,4,5].allUniques)
        XCTAssertFalse(["a","b","c", "c"].allUniques)
        
    }
    
    func testRemove() {
        var testArray1 = [1,2,3,4,1]
        
        testArray1.remove(1)
        XCTAssert(testArray1 == [2,3,4])
        
        var testArray2 = ["a","b","ab","a"]
        testArray2.remove("a")
        XCTAssert(testArray2 == ["b", "ab"])
        
    }
        
    // MARK: - Array<String.Subsequence>
    func testAsStringArray() {
        
        var subseq: [String.SubSequence] = "This is a sentence!".split(separator: " ")
        
        let string = subseq.asStringArray
        
        XCTAssert(string[0] == "This")
        XCTAssert(string[1] == "is")
        XCTAssert(string[2] == "a")
        XCTAssert(string[3] == "sentence!")
        
        subseq = []
        subseq.append(String.SubSequence("zip zap zop"))
        XCTAssert(subseq.asStringArray[0] == "zip zap zop")
        
    }
    
    
    // MARK: - Array<CustomStringConvertible>
    func testAsDelimitedString() {
        
        var expected    = ""
        var actual      = ([CustomStringConvertible]()).asDelimitedString("@")
        XCTAssert( expected == actual, "Expected: \(expected) - Actual: \(actual)")
        
        expected        = "1"
        actual          = [1].asDelimitedString("@")
        XCTAssert( expected == actual, "Expected: \(expected) - Actual: \(actual)")
        
        expected        = "1@2@3@4"
        actual          = [1,2,3,4].asDelimitedString("@")
        XCTAssert( expected == actual, "Expected: \(expected) - Actual: \(actual)")
        
        expected        = "1:2:3:4"
        actual          = [1,2,3,4].asDelimitedString(":")
        XCTAssert( expected == actual, "Expected: \(expected) - Actual: \(actual)")
        
        expected        = "1.1:2.2:3.3:4.4"
        actual          = [1.1,2.2,3.3,4.4].asDelimitedString(":")
        XCTAssert( expected == actual, "Expected: \(expected) - Actual: \(actual)")
        
        expected        = "A->Be->Lee"
        actual          = ["A", "Be", "Lee"].asDelimitedString("->")
        XCTAssert( expected == actual, "Expected: \(expected) - Actual: \(actual)")
        
        
    }
    
    // MARK: - Array<Int>
    func testIntAsDelimitedString() {
        
        var actual = [1,2,3].asDelimitedString("/")
        var expected = "1/2/3"
        XCTAssert(expected == actual, "Expected: \(expected)\nActual: \(actual)")
        
        actual = [1,2,3,4].asDelimitedString("%%")
        expected = "1%%2%%3%%4"
        XCTAssert(expected == actual, "Expected: \(expected)\nActual: \(actual)")
        
        actual = [1,2,3].asDelimitedString("")
        expected = "123"
        XCTAssert(expected == actual, "Expected: \(expected)\nActual: \(actual)")
        
    }
    
    
    func testPercent() {
        let testArray = [1,2,3]
        
        func pct(array: [Int],
                        index i: Int,
                        roundedTo digits: Int) -> Swift.Double? {
            
            guard let percent = array.percent(index: i, roundedTo: digits)
            else {
                
                print("\(array[i]) is nil% of \(array.sum())")
                
                return nil /*EXIT*/
                
            }
            
            print("\(array[i]) is \(percent)% of \(array.sum())")
            
            return percent
            
        }
        
        var p1 = pct(array: testArray, index: 2, roundedTo: 2)
        XCTAssert(p1 == 50.0)
        
        p1 = pct(array: testArray, index: 2, roundedTo: 1)
        XCTAssert(p1 == 50.0)
        
        var p2 = pct(array: testArray, index: 1, roundedTo: 2)
        XCTAssert(p2 == 33.33)
        
        p2 = pct(array: testArray, index: 1, roundedTo: 3)
        XCTAssert(p2 == 33.333)
        
        var p3 = pct(array: [1,0,-1], index: 1, roundedTo: 2)
        XCTAssert(p3 == nil)
        
        p3 = pct(array: [1,0,-1], index: 0, roundedTo: 2)
        XCTAssert(p3 == nil)
        
        p3 = pct(array: [0,0,0], index: 1, roundedTo: 2)
        XCTAssert(p3 == nil)
        
    }
    
    func testAsInt() {
        
        var array           = [1,2,3,4]
        var expected: Int?  = 1234
        var actual: Int?    = array.asInt()!
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        array           = [0,2,3,4]
        expected        = 234
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        array           = [1,0,2,3,4]
        expected        = 10234
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        array           = [0,0,0,3,04]
        expected        = 34
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        array           = [1,0,0,0,0,3,04]
        expected        = 1000034
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        array           = [1,0,0,0,0,0,0]
        expected        = 1000000
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        array           = [-1,0,2,3,4]
        expected        = nil
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        // Large Numbers - No Overflow
        array           = [1234567,89101112,13,14]
        expected        = 1234567891011121314
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        // Large Numbers - Overflow
        array           = [Int.max, Int.max,Int.max]
        expected        = nil
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        array           = Array.init(repeating: 9, count: 100)
        expected        = nil
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        // Single Element Array
        array           = [1234567]
        expected        = 1234567
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        // Empty Array
        array           = [Int]()
        expected        = nil
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
        // Negatives
        array           = Array.init(repeating: -9, count: 5)
        expected        = nil
        actual          = array.asInt()
        XCTAssert(expected == actual, "Expected: \(String(describing: expected)) - Actual: \(String(describing: actual))")
        
    }
    
    
    // MARK: - Array<AdditiveArithmetic>
    func testAddElements() {
        
        var testArray1  = [-10,-2,0,1,2,3,4,5,100]
        let testArray2  = [10,-2,5,-1,4,0,1,6,13]
        
        let expected1    = [0,-4,5,0,6,3,5,11,113]
        
        testArray1.addElements(testArray2)
        
        XCTAssert(testArray1 == expected1, "\nExpected:\t\(expected1)\nActual:\t\(testArray1)")
        
        var testArray3  = [-10.1, 0.0, 2.5, 100.123]
        let testArray4  = [+10.1, 5.66, 1.3, 1.0]
        let expected2   = [0, 5.66, 3.8, 101.123]
        
        testArray3.addElements(testArray4)
        
        XCTAssert(testArray3 == expected2, "\nExpected:\t\(expected2)\nActual:\t\(testArray3)")
        
    }
    
}
