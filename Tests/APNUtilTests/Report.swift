//
//  Report.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 3/26/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class ReportTests: XCTestCase {
    
    func testColumnate() {
        
        // 1
        let headers1    = [" A", " B", " C"]
        let rows1       = [[1,2,3],
                           [4,5,6],
                           [100,200,1000]]
        
        let report1 = Report.columnate(rows1, headers: headers1)
        var lines   = report1.split(separator: "\n",
                                    omittingEmptySubsequences: false)
        
        XCTAssert( lines[0] == "======" )
        XCTAssert( lines[1] == "" )
        XCTAssert( lines[2] == " A B C" )
        XCTAssert( lines[3] == "------" )
        XCTAssert( lines[4] == " 1 2 3" )
        XCTAssert( lines[5] == " 4 5 6" )
        XCTAssert( lines[6] == "000000" )
        XCTAssert( lines[7] == "" )
        // Footnote from lines 8-13
        XCTAssert( lines[14] == "======" )
        
        // 2
        let title       = "Famous People"
        let headers2    = ["  Name  ", " Age ", " Occupation "]
        let rows2       = [["Aaron", "50", "Engineer"],
                           ["Beatrix", "10", "Engineer"],
                           ["Lee", "47", "Financial"]]
        
        let report2 = Report.columnate(rows2,
                                       headers: headers2,
                                       title: title,
                                       dataPadType: .center)
        lines       = report2.split(separator: "\n",
                                    omittingEmptySubsequences: false)
        
        XCTAssert( lines[0] == "=========================")
        XCTAssert( lines[1] == "Famous People" )
        XCTAssert( lines[2] == "" )
        XCTAssert( lines[3] == "  Name   Age  Occupation " )
        XCTAssert( lines[4] == "-------------------------" )
        XCTAssert( lines[5] == "  Aaron   50   Engineer  " )
        XCTAssert( lines[6] == " Beatrix  10   Engineer  " )
        XCTAssert( lines[7] == "   Lee    47   Financial " )
        XCTAssert( lines[8] == "=========================" )
        
        print("""
                
                report1:
                \(report1)
                
                report2:
                \(report2)
                
                """)
        
    }
    
    func testColumnateAutoWidth() {
        
        // 1
        let headers1    = ["A", "B", "C"]
        let rows1       = [[1,2,3],
                           [4,5,6],
                           [100,200,1000]]
        
        let report1 = Report.columnateAutoWidth(rows1, headers: headers1)
        var lines   = report1.split(separator: "\n",
                                    omittingEmptySubsequences: false)
        
        XCTAssert( lines[0] == "================")
        XCTAssert( lines[1] == "")
        XCTAssert( lines[2] == "  A    B     C  ")
        XCTAssert( lines[6] == "  100  200  1000")
        XCTAssert( lines[3] == "----------------")
        XCTAssert( lines[4] == "    1    2     3")
        XCTAssert( lines[5] == "    4    5     6")
        XCTAssert( lines[6] == "  100  200  1000")
        XCTAssert( lines[7] == "================")
        
        // 2
        let title       = "Famous People"
        let headers2    = ["  Name  ", " Age ", " Occupation "]
        let rows2       = [["Aaron", "50", "Engineer"],
                           ["Beatrix", "10", "Engineer"],
                           ["Lee", "47", "Financial"]]
        
        let report2 = Report.columnateAutoWidth(rows2,
                                                headers: headers2,
                                                title: title,
                                                dataPadType: .center)
        lines       = report2.split(separator: "\n",
                                    omittingEmptySubsequences: false)
        
        XCTAssert( lines[0] == "===============================")
        XCTAssert( lines[1] == "Famous People" )
        XCTAssert( lines[2] == "" )
        XCTAssert( lines[3] == "   Name     Age    Occupation  " )
        XCTAssert( lines[4] == "-------------------------------" )
        XCTAssert( lines[5] == "   Aaron     50     Engineer   ")
        XCTAssert( lines[6] == "  Beatrix    10     Engineer   " )
        XCTAssert( lines[7] == "    Lee      47     Financial  " )
        XCTAssert( lines[8] == "===============================" )
        
        print("""
                
                report1:
                \(report1)
                
                report2:
                \(report2)
                
                """)
        
    }
    
    func testCSV() {
        
        // 1
        let headers1    = ["A", "B", "C"]
        let rows1       = [[1,2,3],
                           [4,5,6],
                           [100,200,1000]]
                
        func comp(_ line: String, _ compareTo: [String]) -> Bool {
            
            let lines = line.components(separatedBy: "\t")
            return lines == compareTo
            
        }
        
        let report1     = Report.csv(rows1, title: "Report #1", headers: headers1)
        var lines       = report1.components(separatedBy: "\n")
        var expected    = ""
        var actual      = ""

        expected    = "Report #1"
        actual      = lines[0]
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")

        expected    = "A,B,C"
        actual      = lines[1]
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        expected    = "1,2,3"
        actual      = lines[2]
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")

        expected    = "4,5,6"
        actual      = lines[3]
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")

        expected    = "100,200,1000"
        actual      = lines[4]
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        // 2
        let headers2    = ["Name", "Age", "Occupation"]
        let rows2       = [["Aaron", "50", "Engineer"],
                           ["Beatrix", "10", "Engineer"],
                           ["Lee", "47", "Financial"]]
        
        let report2 = Report.csv(rows2,
                                 title: "Report #2",
                                 headers: headers2)
        
        lines       = report2.components(separatedBy: "\n")
        
        expected    = "Report #2"
        actual      = lines[0]
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        expected    = "Name,Age,Occupation"
        actual      = lines[1]
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        expected    = "Aaron,50,Engineer"
        actual      = lines[2]
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        expected    = "Beatrix,10,Engineer"
        actual      = lines[3]
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        expected    = "Lee,47,Financial"
        actual      = lines[4]
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        print("""
                    \(report1)
                    
                    \(report2)
                    
                    """)
        
    }
    
}
