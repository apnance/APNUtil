//
//  CollectionTests.swift
//  APNUtil
//
//  Created by Aaron Nance on 2/9/26.
//

import XCTest
import APNUtil

class CollectionTests: XCTestCase {
    
    func testAsArray() {
        
        struct Greeble: Equatable { let name: String }
        
        let array1  = [1, 2, 3]
        let array2  = ["1", "2", "3"]
        let array3  = [Greeble(name: "pip"), Greeble(name: "win"), Greeble(name: "kit")]
            
        let slice1  = array1.prefix(array1.count)
        let slice2  = array2.prefix(array2.count)
        let slice3  = array3.prefix(array3.count)
        
        let array1b = slice1.asArray
        let array2b = slice2.asArray
        let array3b = slice3.asArray
        
        XCTAssert(array1 == array1b)
        XCTAssert(array2 == array2b)
        XCTAssert(array3 == array3b)
        
        XCTAssert(array1 == array1.prefix(array1.count).asArray)
        XCTAssert(array2 == array2.prefix(array2.count).asArray)
        XCTAssert(array3 == array3.prefix(array3.count).asArray)
        
    }
    
}
