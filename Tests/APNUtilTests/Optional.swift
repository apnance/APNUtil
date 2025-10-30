//
//  Optional.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/14/22.
//  Copyright © 2022 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

final class Optional: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // - MARK: Optional
    func testIsNil() {

        // String
        var optionalString: String? =    nil
        XCTAssert(optionalString.isNil)
        
        optionalString              = "not nil now"
        XCTAssertFalse(optionalString.isNil)
        
        optionalString              = nil
        XCTAssert(optionalString.isNil)
        
        // Int
        var optionalInt: Int?       =    123
        XCTAssertFalse(optionalInt.isNil)
        
        optionalInt                 = nil
        XCTAssert(optionalInt.isNil)
        
        optionalInt                 = -135464
        XCTAssertFalse(optionalInt.isNil)
        
    }
    
    func testIsNilOrEmpty() {

        struct Zoink { }
        
        var optionalStringArray: [String]? =    nil
        XCTAssert(optionalStringArray.isNilOrEmpty)
        
        optionalStringArray = []
        XCTAssert(optionalStringArray.isNilOrEmpty)
        
        optionalStringArray = ["zoink"]
        XCTAssertFalse(optionalStringArray.isNilOrEmpty)
        
        optionalStringArray?.append("boink")
        XCTAssertFalse(optionalStringArray.isNilOrEmpty)
        
        var optionalIntArray: [Int]? =    nil
        XCTAssert(optionalIntArray.isNilOrEmpty)
        
        optionalIntArray = []
        XCTAssert(optionalIntArray.isNilOrEmpty)
        
        optionalIntArray = [1]
        XCTAssertFalse(optionalIntArray.isNilOrEmpty)
        
        optionalIntArray?.append(999)
        XCTAssertFalse(optionalIntArray.isNilOrEmpty)
        
        var optionalZoinkArray: [Zoink]? =    nil
        XCTAssert(optionalZoinkArray.isNilOrEmpty)
        
        optionalZoinkArray = []
        XCTAssert(optionalZoinkArray.isNilOrEmpty)
        
        optionalZoinkArray = [Zoink()]
        XCTAssertFalse(optionalZoinkArray.isNilOrEmpty)
        
        optionalZoinkArray?.append(Zoink())
        XCTAssertFalse(optionalZoinkArray.isNilOrEmpty)
        
    }
    
    func testIsNotNil() {

        // String
        var optionalString: String? =    nil
        XCTAssertFalse(optionalString.isNotNil)
        
        optionalString              = "not nil now"
        XCTAssert(optionalString.isNotNil)
        
        optionalString              = nil
        XCTAssertFalse(optionalString.isNotNil)
        
        // Int
        var optionalInt: Int?       =    123
        XCTAssert(optionalInt.isNotNil)
        
        optionalInt                 = nil
        XCTAssertFalse(optionalInt.isNotNil)
        
        optionalInt                 = -135464
        XCTAssert(optionalInt.isNotNil)
        
    }
    
    // - MARK: [String]?
    func testElementNum() {
        
        let nilArray: [String]? = nil
        
        XCTAssert(nilArray.elementNum(Int.min) == "")
        XCTAssert(nilArray.elementNum(-1) == "")
        XCTAssert(nilArray.elementNum(0) == "")
        XCTAssert(nilArray.elementNum(1) == "")
        XCTAssert(nilArray.elementNum(Int.max) == "")
        
        var threeElementArray: [String]? = []
        XCTAssert(threeElementArray.elementNum(Int.min) == "")
        XCTAssert(threeElementArray.elementNum(-1) == "")
        XCTAssert(threeElementArray.elementNum(0) == "")
        XCTAssert(threeElementArray.elementNum(1) == "")
        XCTAssert(threeElementArray.elementNum(Int.max) == "")
        
       threeElementArray = ["Zero", "On3", "2"]
        
        XCTAssert(threeElementArray.elementNum(Int.min) == "")
        XCTAssert(threeElementArray.elementNum(-1) == "")
        XCTAssert(threeElementArray.elementNum(0) == "Zero")
        XCTAssert(threeElementArray.elementNum(1) == "On3")
        XCTAssert(threeElementArray.elementNum(2) == "2")
        XCTAssert(threeElementArray.elementNum(3) == "")
        XCTAssert(threeElementArray.elementNum(Int.max) == "")
        
        threeElementArray = nil
        XCTAssert(threeElementArray.elementNum(Int.min) == "")
        XCTAssert(threeElementArray.elementNum(-1) == "")
        XCTAssert(threeElementArray.elementNum(0) == "")
        XCTAssert(threeElementArray.elementNum(1) == "")
        XCTAssert(threeElementArray.elementNum(Int.max) == "")
        
    }
    
    func testElementCount() {
        
        let nilArray: [String]? = nil
        
        XCTAssert(nilArray.elementCount == 0)
        
        var startsNilArray: [String]?
        XCTAssert(startsNilArray.elementCount == 0)
        
        startsNilArray = ["Fred"]
        XCTAssert(startsNilArray.elementCount == 1)
        
        startsNilArray?.append("Barney")
        XCTAssert(startsNilArray.elementCount == 2)
        
        startsNilArray?.removeAll()
        XCTAssert(startsNilArray.elementCount == 0)
        
    }
    
}
