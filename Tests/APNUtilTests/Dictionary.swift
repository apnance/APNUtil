//
//  Dictionary.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/24/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class DictionaryTests: XCTestCase {
    
    var fruit   = [String: Int]()
    var words   = [String: Int]()
    let shapes  = ["circle": 10, "square": 3, "triangle": 2]
    
    override func setUp() {
        
        fruit["apple"]  = 3
        fruit["orange"] = 1
        fruit["banana"] = 2
        fruit["kiwi"]   = -20
        
        fruit.add("apple", 4)
        
        words = TestData.wordsDictionary
        
    }
    
    func testWeightedArray() {
        
        let fruitWA = fruit.weightedArray()
        
        XCTAssert(fruitWA.countOf("apple")  == 7)
        XCTAssert(fruitWA.countOf("orange") == 1)
        XCTAssert(fruitWA.countOf("banana") == 2)
        XCTAssert(fruitWA.countOf("kiwi")   == 0)
        
        loud("\(#function):\n\(fruit)")
        
     }
    
    /// Note: this test can fail, it's based on randomness and an estimate of what should be
    ///     minimum deviation from idealized percentages.  Take failure of this test with grain of salt.
    func testRandomKeyFromWeighted() {
        
        var results = fruit.zeroCopy()
        let totalIters = 50000
        
        for _ in 0...totalIters {
          
            // Get a random key from weighted array
            let randKey = fruit.randomKeyFromWeighted()!
            
            // Increment results dictionary
            results.add(randKey, 1)
            
        }
        
        let percentages = results.percentages(roundedTo: 2)
        
        XCTAssert(percentages["apple"]!  >= 68.0,   "\(percentages["apple"]!)")
        XCTAssert(percentages["orange"]! >= 8.0,    "\(percentages["orange"]!)" )
        XCTAssert(percentages["banana"]! >= 18.0,   "\(percentages["banana"]!)" )
        XCTAssert(percentages["kiwi"]!   == 0.0,    "\(percentages["kiwi"]!)")
        
        loud("\(#function):\n\(fruit.weightedArray())")
        loud("\(#function):\n\(percentages)")
        
    }
    
    func testSum() {
        
        let dict1 = [ "1" : 1, "2" : 2, "3" : 3, "4" : 4 ]
        assert(dict1.sum == 10)
        
        let dict2 = [ 1 : 1, 2 : 2, 3 : 3, 4 : 4 ]
        assert(dict2.sum == 10)
        
        let dict3 = [ -1 : -1, -2 : -2, 2 : 2 ]
        assert(dict3.sum == -1)
        
        let dict4 = [ -1 : -1, 1 : -1, 0 : 0 ]
        assert(dict4.sum == -2)
        
    }
    
    func testAdd() {
        
        // Add Single Value to All
        //  Int
        var shapes          = ["circle": 0, "square": 0]
        var currentShape    = "triangle"
        
        shapes.add(currentShape, 2)
        XCTAssert(shapes[currentShape] == 2)
        
        shapes.add(currentShape, -2)
        XCTAssert(shapes[currentShape] == 0)
        
        shapes.add(currentShape, 10)
        shapes.add(currentShape, -100)
        XCTAssert(shapes[currentShape] == -90)

        currentShape = "diamond"
        shapes.add(currentShape, 1)
        XCTAssert(shapes[currentShape] == 1)
        
        currentShape = "pentagram"
        shapes.add(currentShape, -1)
        XCTAssert(shapes[currentShape] == -1)
        
        shapes = [:]
        
        XCTAssert(shapes.count == 0)
        
        shapes.add(["rhombus", "hexagon"], 2)
        XCTAssert(shapes["rhombus"] == 2)
        XCTAssert(shapes["hexagon"] == 2)
        
        shapes.add(["rhombus", "hexagon", "circle"], -2)
        XCTAssert(shapes["rhombus"] == 0)
        XCTAssert(shapes["hexagon"] == 0)
        XCTAssert(shapes["circle"] == -2)
        
        //  Double
        var shapes2          = ["circle": 0.0, "square": 0.0]
        var currentShape2    = "triangle"
        
        shapes2.add(currentShape2, 2.0)
        XCTAssert(shapes2[currentShape2] == 2.0)
        
        shapes2.add(currentShape2, -2.0)
        XCTAssert(shapes2[currentShape2] == 0.0)

        
        shapes2.add(currentShape2, 10.0)
        shapes2.add(currentShape2, -100.0)
        XCTAssert(shapes2[currentShape2] == -90.0)

        currentShape2 = "diamond"
        shapes2.add(currentShape2, 1.0)
        XCTAssert(shapes2[currentShape2] == 1.0)
        
        currentShape2 = "pentagram"
        shapes2.add(currentShape2, -1.0)
        XCTAssert(shapes2[currentShape2] == -1.0)
        
        shapes2 = [:]
        
        XCTAssert(shapes2.count == 0)
        
        shapes2.add(["rhombus", "hexagon"], 2.0)
        XCTAssert(shapes2["rhombus"] == 2.0)
        XCTAssert(shapes2["hexagon"] == 2.0)
        
        shapes2.add(["rhombus", "hexagon", "circle"], -2.0)
        XCTAssert(shapes2["rhombus"] == 0.0)
        XCTAssert(shapes2["hexagon"] == 0.0)
        XCTAssert(shapes2["circle"] == -2.0)
        
        // Add Dictionaries
        //  Int
        var fruits1  = ["apple": 1, "orange": 2, "banana": 3]
        let fruits2  = ["apple": 3, "pear": 10, "banana": 0]
        fruits1.add(fruits2)
        XCTAssert(fruits1["apple"] == 4)
        XCTAssert(fruits1["orange"] == 2)
        XCTAssert(fruits1["banana"] == 3)
        XCTAssert(fruits1["pear"] == 10)
        
        //  Double
        var fruits3  = ["apple": 1.0, "orange": 2.0, "banana": 3.0]
        let fruits4  = ["apple": 3.0, "pear": 10.0, "banana": 0.0]
        fruits3.add(fruits4)
        XCTAssert(fruits3["apple"] == 4.0)
        XCTAssert(fruits3["orange"] == 2.0)
        XCTAssert(fruits3["banana"] == 3.0)
        XCTAssert(fruits3["pear"] == 10.0)
        
    }
    
    func testSubtract() {
        var shapes = self.shapes
        var currentShape = "circle"
        
        shapes.subtract(currentShape, 2)
        XCTAssert(shapes[currentShape] == 8)
        
        shapes.subtract(currentShape, 10)
        XCTAssert(shapes[currentShape] == -2)
        
        shapes.subtract(currentShape, -2)
        XCTAssert(shapes[currentShape] == 0)
        
        currentShape = "blarg"
        XCTAssert(shapes[currentShape] == nil)
        
        shapes.subtract(["circle" , "square", "triangle"], 2)
        XCTAssert(shapes["square"] == 1)
        XCTAssert(shapes["triangle"] == 0)
        XCTAssert(shapes["circle"] == -2)
        
    }
    
    func testEachTimes() {
        
        // Dictionary<Int,Double>
        let dict1 = [ 0: 0.0, 1: 1.1, 2: 2.22, 3: 3.333 ]
        let eachTimes1 = dict1.eachTimes(2)
        
        XCTAssert(eachTimes1[0] == 0.0)
        XCTAssert(eachTimes1[1] == 2.2)
        XCTAssert(eachTimes1[2] == 4.44)
        XCTAssert(eachTimes1[3] == 6.666)
        
        print("\(#function) \(eachTimes1)")
        
        // Dictionary<String,Double>
        let dict2 = ["ten":10.0, "twelve":12, "twenty":20]
        let eachTimes2 = dict2.eachTimes(10)
        
        XCTAssert(eachTimes2["ten"]      == 100.0)
        XCTAssert(eachTimes2["twelve"]   == 120.0)
        XCTAssert(eachTimes2["twenty"]   == 200.0)
        
        print("\(#function) \(eachTimes2)")
        
        let dict3 = [ 0: 0, 1: 1, 2: 2, 3: -3]
        let eachTimes3 = dict3.eachTimes(2)
        
        XCTAssert(eachTimes3[0] == 0)
        XCTAssert(eachTimes3[1] == 2)
        XCTAssert(eachTimes3[2] == 4)
        XCTAssert(eachTimes3[3] == -6)
        
        print("\(#function) \(eachTimes2)")
        
        // Dictionary<String,Double>
        let dict4 = ["ten": 10, "twelve": 12, "twenty": 20]
        let eachTimes4 = dict4.eachTimes(10)
        
        XCTAssert(eachTimes4["ten"]      == 100)
        XCTAssert(eachTimes4["twelve"]   == 120)
        XCTAssert(eachTimes4["twenty"]   == 200)
        
        print("\(#function) \(eachTimes2)")
        
    }
    
    func testPercent() {
        
        enum Topsy { case blah, blip, blob }
        
        let numberDict = [ "one" :1, "two" :2, "three" : 3, "four" : 4, "five" : 5 ]
        let topsyDict: [Topsy : Int] = [.blah : 5, .blip : 15, .blob: 20]
        
        let percentSquare = shapes.percent("circle", roundedTo: 5)!
        XCTAssert(percentSquare == 66.66667)
        
        let numberDictPercent = numberDict.percent("five", roundedTo: 2)!
        XCTAssert(numberDictPercent == 33.33)
        
        let topsyDictPercent = topsyDict.percent(.blob, roundedTo: 2)!
        XCTAssert(topsyDictPercent == 50.00)
        
    }
    
    func testRandomElementsFromWeighted() {
        
        var results = [String: Int]()
        
        let totalIters = 10000
        
        for _ in 0...totalIters {
              
            let randoms = words.randomKeysFromWeighted(3)
            
            randoms.forEach{ results.add($0, 1) }
        
        }
        
        let percentages = results.percentages(roundedTo: 2)
        
        percentages.printSimple()
        words.percentages(roundedTo: 2).printSimple()
        
        // == 0
        XCTAssert(percentages["dictation"] == nil)
        XCTAssert(percentages["prediction"] == nil)
        XCTAssert(percentages["overpopulate"] == nil)
        XCTAssert(percentages["dictate"] == nil)
        XCTAssert(percentages["universe"] == nil)
        XCTAssert(percentages["information"] == nil)
        XCTAssert(percentages["decimeter"] == nil)
        XCTAssert(percentages["format"] == nil)
        XCTAssert(percentages["monopoly"] == nil)
        XCTAssert(percentages["centimeter"] == nil)
        XCTAssert(percentages["omnipotent"] == nil)
        XCTAssert(percentages["decade"] == nil)
        XCTAssert(percentages["populous"] == nil)
        XCTAssert(percentages["popular"] == nil)
        XCTAssert(percentages["decathlon"] == nil)
        XCTAssert(percentages["informative"] == nil)
        XCTAssert(percentages["popularize"] == nil)
        XCTAssert(percentages["predict"] == nil)
        XCTAssert(percentages["depopulate"] == nil)
        XCTAssert(percentages["biochemistry"] == nil)
        XCTAssert(percentages["formal"] == nil)
        XCTAssert(percentages["populate"] == nil)
        XCTAssert(percentages["century"] == nil)
        XCTAssert(percentages["unpopular"] == nil)
        XCTAssert(percentages["deform"] == nil)
        XCTAssert(percentages["salami"] == nil)
        XCTAssert(percentages["decapod"] == nil)
        XCTAssert(percentages["terrarium"] == nil)
        XCTAssert(percentages["uniform"] == nil)
        XCTAssert(percentages["cuneiform"] == nil)
        XCTAssert(percentages["verdict"] == nil)
        XCTAssert(percentages["repopulate"] == nil)
        XCTAssert(percentages["inform"] == nil)
        XCTAssert(percentages["geode"] == nil)
        XCTAssert(percentages["carnivore"] == nil)
        XCTAssert(percentages["centenarion"] == nil)
        XCTAssert(percentages["diction"] == nil)
        XCTAssert(percentages["saline"] == nil)
        XCTAssert(percentages["formula"] == nil)
        XCTAssert(percentages["microbiology"] == nil)
        XCTAssert(percentages["herbivore"] == nil)
        XCTAssert(percentages["geographic"] == nil)
        XCTAssert(percentages["territory"] == nil)
        XCTAssert(percentages["contradict"] == nil)
        XCTAssert(percentages["formless"] == nil)
        
        // > 0
        XCTAssert(percentages["geologist"]! >= 6.5)
        XCTAssert(percentages["monotone"]! >= 1.5)
        XCTAssert(percentages["voracious"]! >= 3.5)
        XCTAssert(percentages["bicycle"]! >= 1.5)
        XCTAssert(percentages["dictionary"]! >= 1.5)
        XCTAssert(percentages["omnivore"]! >= 1.5)
        XCTAssert(percentages["salary"]! >= 1.5)
        XCTAssert(percentages["biplane"]! >= 1.5)
        XCTAssert(percentages["percent"]! >= 1.5)
        XCTAssert(percentages["devour"]! >= 3.5)
        XCTAssert(percentages["conform"]! >= 1.5)
        XCTAssert(percentages["omniscient"]! >= 1.5)
        XCTAssert(percentages["decibel"]! >= 4.5)
        XCTAssert(percentages["dictator"]! >= 3.5)
        XCTAssert(percentages["billion"]! >= 1.5)
        XCTAssert(percentages["benediction"]! >= 6.5)
        XCTAssert(percentages["popularity"]! >= 1.5)
        XCTAssert(percentages["population"]! >= 8.5)
        XCTAssert(percentages["indicate"]! >= 1.5)
        XCTAssert(percentages["amphibious"]! >= 5.5)
        XCTAssert(percentages["geography"]! >= 1.5)
        XCTAssert(percentages["reform"]! >= 1.5)
        XCTAssert(percentages["unicorn"]! >= 0.5)
        XCTAssert(percentages["mediterranean"]! >= 5.5)
        XCTAssert(percentages["decimal"]! >= 1.5)
        XCTAssert(percentages["herbal"]! >= 3.5)
        XCTAssert(percentages["universal"]! >= 5.5)
        
    }
    
    func testSwapKeys() {
        var shapes = self.shapes
        
        XCTAssert(shapes.count == 3)
        
        XCTAssert(shapes["circle"] != nil)
        XCTAssert(shapes["square"] != nil)
        XCTAssert(shapes["triangle"] != nil)
        
        shapes.swapKey("circle", " CIR CLE ")
        shapes.swapKey("square", "SquarE ")
        shapes.swapKey("triangle", "Triangle")
        
        XCTAssert(shapes["circle"] == nil)
        XCTAssert(shapes["square"] == nil)
        XCTAssert(shapes["triangle"] == nil)
        
        shapes.cleanKeys(String.lowerNoSpaces)
        
        XCTAssert(shapes["circle"] != nil)
        XCTAssert(shapes["square"] != nil)
        XCTAssert(shapes["triangle"] != nil)
        
        shapes.swapKey("circle", "WHOHOO")
        XCTAssert(shapes["circle"] == nil)
        XCTAssert(shapes["WHOHOO"] != nil)
        
        shapes.swapKey("MISSING", "NIL")
        XCTAssert(shapes["MISSING"] == nil)
        XCTAssert(shapes["NIL"] == nil)
        
        XCTAssert(shapes.count == 3)
        
    }
    
    func testCleanKeys() {
        
        let key0 = " A a123 "
        let key1 = "XXXXX"
        let key2 = " A b C d E "
        
        var dirty = [ key0 : 3,
                     key1 : 5,
                     key2 : 7]
        
        XCTAssert(dirty.count == 3)
        
        XCTAssert(dirty[key0] == 3)
        XCTAssert(dirty[key1] == 5)
        XCTAssert(dirty[key2] == 7)
        
        dirty.cleanKeys(String.lowerNoSpaces)
        
        XCTAssert(dirty[key0] == nil)
        XCTAssert(dirty[key1] == nil)
        XCTAssert(dirty[key2] == nil)
        
        XCTAssert(dirty["aa123"] == 3)
        XCTAssert(dirty["xxxxx"] == 5)
        XCTAssert(dirty["abcde"] == 7)
        
        dirty.cleanKeys( { $0.uppercased() } )
        XCTAssert(dirty["AA123"] == 3)
        XCTAssert(dirty["XXXXX"] == 5)
        XCTAssert(dirty["ABCDE"] == 7)
        
    }
    
}
