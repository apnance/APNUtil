//
//  CodableArchiverTests.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 5/19/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class CodableArchiverTests: XCTestCase {
    
    func testArchiveIntArray() {
        
        let testArray1 = [0,1,2,3,4,5]
        
        var fileName = "test_file_name_1"
        var fileDir: String? = nil
        
        CodableArchiver.archive(testArray1,
                                toFile: fileName,
                                inSubDir: fileDir)
        
        
        var testArray2: [Int]! = CodableArchiver.unarchive(file: fileName,
                                                             inSubDir: fileDir)
        
        XCTAssert(testArray2 == testArray1)
        
        testArray2.append(10)
        
        fileName    = "test_file_name_2"
        fileDir     = "test_file_dir"
        CodableArchiver.archive(testArray2,
                                toFile: fileName,
                                inSubDir: fileDir)
        
        let testArray3: [Int]! = CodableArchiver.unarchive(file: fileName,
                                                           inSubDir: fileDir)
        
        XCTAssert(testArray3 != testArray1)
        XCTAssert(testArray3 == testArray2)
        
    }
    
    func testArchiveSimpleTestClassArray() {
        
        var fileName = "test_file_name_1"
        var fileDir: String? = nil
        let testClass1 = SimpleTestClass(name: "TC1", number: 1)
        let testClass2 = SimpleTestClass(name: "TC2", number: 2)
        let testClass3 = SimpleTestClass(name: "TC3", number: nil)
        let testClass4 = SimpleTestClass(name: nil,   number: nil)
        
        var testArray1 = [testClass1, testClass2, testClass3, testClass4]
        
        fileName    = "test_file_name_3"
        fileDir     = "test_file_dir"
        CodableArchiver.archive(testArray1,
                                toFile: fileName,
                                inSubDir: fileDir)
        
        let testArray2: [SimpleTestClass]! = CodableArchiver.unarchive(file: fileName,
                                                                       inSubDir: fileDir)
        
        XCTAssert(testArray2 == testArray1)
        
        testArray1.removeLast()
        XCTAssert(testArray2 != testArray1)
        
    }
    
}
