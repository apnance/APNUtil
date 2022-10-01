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
    
    
}
