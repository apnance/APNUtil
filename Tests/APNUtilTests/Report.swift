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
    
    let headers = [" UNUS ",
                   " DUO ",
                   " TRES ",
                   " QUATTUOR ",
                   " QUINQUE ",
                   " SEX ",
                   " SEPTEM ",
                   " OCTO ",
                   " NOVEM ",
                   " DECEM ",
                   " UNDECIM ",
                   " DUODECIM ",
                   " TREDECIM ",
                   " QUATTUORDECIM ",
                   " QUINDECIM "]
    
    let data    = ["1", "2", "3", "A", "B", "C", "Dog", "Cat", "Fish", "Aaron", "Bea", "Lee", "!@#!@"]
    
    func check(_ expected: String, _ actual: String) {
        
        XCTAssert(expected == actual, """
            
            Expected:
            '\(expected)'
            
            Actual:
            '\(actual)'
            
            """)
        
    }
    
    /// Trims and splits both `expected` and `actual` before  comparing the
    /// resulting arrays line by line expecting equality.
    func checkMultiline(_ expected: String, _ actual: String) {
        
        let expectedLines   = expected.trim().split(separator: "\n",
                                             omittingEmptySubsequences: false).asStringArray
        
        let actualLines     = actual.trim().split(separator: "\n",
                                             omittingEmptySubsequences: false).asStringArray
        
        if actualLines.count != expectedLines.count {
            
            XCTAssert(false, """
                            
                            Line Counts Differ:
                            Expected: \(expectedLines.count) lines
                            Actual:   \(actualLines.count) lines
                            
                            """)
            
        } else {
            
            for (i, expected) in expectedLines.enumerated() {
                
                check(expected, actualLines[i])
                
            }
            
        }
        
    }
    
    func testColumnateSimple() {
        
        // Headers
        var report = Report.columnateSimple(data,
                                            headers: headers,
                                            colCount: 2,
                                            dataPadType: .left,
                                            useAutoWidth: true)
        
        checkMultiline(report, """
                                ================
                                  UNUS    DUO  
                                ----------------
                                       1    Cat
                                       2   Fish
                                       3  Aaron
                                       A    Bea
                                       B    Lee
                                       C  !@#!@
                                     Dog      -
                                ================
                                """)
        
        report = Report.columnateSimple(data.prefix(4).asArray,
                                        headers: headers,
                                        colCount: 2,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                ================
                                  UNUS    DUO  
                                ----------------
                                       1      3
                                       2      A
                                ================
                                """)
        
        report = Report.columnateSimple(data,
                                        headers: headers,
                                        colCount: 2,
                                        dataPadType: .right,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                ================
                                  UNUS    DUO  
                                ----------------
                                1       Cat    
                                2       Fish   
                                3       Aaron  
                                A       Bea    
                                B       Lee    
                                C       !@#!@  
                                Dog     -      
                                ================
                                """)
                
        report = Report.columnateSimple(data.prefix(data.lastUsableIndex).asArray,
                                        headers: headers,
                                        colCount: 3,
                                        dataPadType: .right,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                ========================
                                  UNUS    DUO    TRES  
                                ------------------------
                                1       B      Fish    
                                2       C      Aaron   
                                3       Dog    Bea     
                                A       Cat    Lee     
                                ========================
                                """)
        
        report = Report.columnateSimple(data.prefix(data.lastUsableIndex - 3).asArray,
                                        headers: headers,
                                        colCount: 3,
                                        dataPadType: .right,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                ========================
                                  UNUS    DUO    TRES  
                                ------------------------
                                1       A      Dog     
                                2       B      Cat     
                                3       C      Fish    
                                ========================
                                """)
        
        report = Report.columnateSimple(data.prefix(data.lastUsableIndex - 2).asArray,
                                        headers: headers,
                                        colCount: 3,
                                        dataPadType: .center,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                ========================
                                  UNUS    DUO    TRES  
                                ------------------------
                                    1      B     Fish  
                                    2      C     Aaron 
                                    3     Dog      -   
                                    A     Cat      -   
                                ========================
                                """)
        
        report = Report.columnateSimple(data.prefix(4).asArray,
                                        headers: headers,
                                        colCount: 3,
                                        dataPadType: .center,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                ========================
                                  UNUS    DUO    TRES  
                                ------------------------
                                    1      3       -   
                                    2      A       -   
                                ========================
                                """)
        
        printToClipboard(report) // TODO: Clean Up - delete printToClipboard()
        
        report = Report.columnateSimple(data,
                                        headers: headers,
                                        colCount: data.count,
                                        dataPadType: .center,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                =============================================================================================================================
                                  UNUS    DUO    TRES    QUATTUOR    QUINQUE    SEX    SEPTEM    OCTO    NOVEM    DECEM    UNDECIM    DUODECIM    TREDECIM  
                                -----------------------------------------------------------------------------------------------------------------------------
                                    1      2       3         A          B        C       Dog      Cat     Fish    Aaron      Bea         Lee        !@#!@   
                                =============================================================================================================================
                                """)
        
        report = Report.columnateSimple(data,
                                        headers: headers,
                                        colCount: data.count,
                                        dataPadType: .center,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                =============================================================================================================================
                                  UNUS    DUO    TRES    QUATTUOR    QUINQUE    SEX    SEPTEM    OCTO    NOVEM    DECEM    UNDECIM    DUODECIM    TREDECIM  
                                -----------------------------------------------------------------------------------------------------------------------------
                                    1      2       3         A          B        C       Dog      Cat     Fish    Aaron      Bea         Lee        !@#!@   
                                =============================================================================================================================
                                """)
        
        
        // No-Headers
        report = Report.columnateSimple(data,
                                        colCount: 2,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                    1    Cat
                                    2   Fish
                                    3  Aaron
                                    A    Bea
                                    B    Lee
                                    C  !@#!@
                                  Dog      -
                                """)
        
        for i in 0...data.lastUsableIndex {
            
            // Empty Data, Varying Lenghts of Headers
            let headers = headers.prefix(i).asArray
            
            report = Report.columnateSimple([],
                                            headers: headers,
                                            colCount: i,
                                            dataPadType: .left,
                                            useAutoWidth: true)
            
            checkMultiline(report, "")
            
        }
        
        report = Report.columnateSimple(data.prefix(1).asArray,
                                        colCount: 1,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                  1
                                """)
        
        report = Report.columnateSimple(data.prefix(2).asArray,
                                        colCount: 1,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                  1
                                  2
                                """)
        
        report = Report.columnateSimple(data.prefix(4).asArray,
                                        colCount: 1,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                  1
                                  2
                                  3
                                  A
                                """)
        
        
        report = Report.columnateSimple(data.prefix(7).asArray,
                                        colCount: 3,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                  1  A  Dog
                                  2  B    -
                                  3  C    -
                                """)
        
        report = Report.columnateSimple(data.prefix(6).asArray,
                                        colCount: 3,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                  1  3  B
                                  2  A  C
                                """)
        
        report = Report.columnateSimple(data.prefix(6).asArray,
                                        colCount: 2,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                  1  A
                                  2  B
                                  3  C
                                """)
        
        report = Report.columnateSimple(data.prefix(5).asArray,
                                        colCount: 3,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                  1  3  B
                                  2  A  -
                                """)
        
        report = Report.columnateSimple(data.prefix(4).asArray,
                                        colCount: 3,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                  1  3  -
                                  2  A  -
                                """)
        
        report = Report.columnateSimple(data.prefix(4).asArray,
                                        colCount: 2,
                                        dataPadType: .left,
                                        useAutoWidth: true)
        
        checkMultiline(report, """
                                  1  3
                                  2  A
                                """)
        
    }
    
    func testColumnateSimpleNOASSERTS() {
        
        for i in 1...data.lastUsableIndex {
            
            let subData = Array(data[0...i])
            
            print("Data Count: \(subData.count)")
            print("----------")
            
            for j in 1...(subData.count + 1) {
                
                let colCount    = j
                let rowCount    = subData.count / colCount + (subData.count % colCount > 0 ? 1 : 0)
                let subHeaders  = Array(headers[0..<colCount])
                
                print("-- Rows:\(rowCount) - Cols:\(j) --")
                
                print("No Auto-Width:")
                print(Report.columnateSimple(subData,
                                             headers: subHeaders,
                                             colCount: colCount,
                                             useAutoWidth: false))
                
                print("Auto-Width (Headers):")
                print(Report.columnateSimple(subData,
                                             headers: subHeaders,
                                             colCount: colCount,
                                             useAutoWidth: true))
                
                print("Auto-Width (No Headers):")
                print(Report.columnateSimple(subData,
                                             colCount: colCount,
                                             useAutoWidth: true))
                
            }
            
            print("- - - - - - ")
            
        }
        
    }
    
    func testColumnate() {
        
        // 1
        let headers1    = [" A", " B", " C"]
        let rows1       = [[1,2,3],
                           [4,5,6],
                           [100,200,1000]]
        
        let report1 = Report.columnate(rows1, headers: headers1)
        var lines   = report1.split(separator: "\n",
                                    omittingEmptySubsequences: false)
        
        XCTAssert( lines[0] == "========" )
        XCTAssert( lines[1] == " A B C" )
        XCTAssert( lines[2] == "--------")
        XCTAssert( lines[3] == " 1 2 3" )
        XCTAssert( lines[4] == " 4 5 6" )
        XCTAssert( lines[5] == "000000" )
        XCTAssert( lines[6] == "" )
        XCTAssert( lines[13] == "========" )
        
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
        
        XCTAssert( lines[0] == "===========================")
        XCTAssert( lines[1] == "Famous People" )
        XCTAssert( lines[2] == "  Name   Age  Occupation " )
        XCTAssert( lines[3] == "---------------------------" )
        XCTAssert( lines[4] == "  Aaron   50   Engineer  " )
        XCTAssert( lines[5] == " Beatrix  10   Engineer  " )
        XCTAssert( lines[6] == "   Lee    47   Financial " )
        XCTAssert( lines[7] == "===========================" )
        
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
        
        XCTAssert( lines[0] == "=================")
        XCTAssert( lines[1] == "  A    B     C  ")
        XCTAssert( lines[2] == "-----------------")
        XCTAssert( lines[3] == "    1    2     3")
        XCTAssert( lines[4] == "    4    5     6")
        XCTAssert( lines[5] == "  100  200  1000")
        XCTAssert( lines[6] == "=================")
        
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
        
        XCTAssert( lines[0] == "================================")
        XCTAssert( lines[1] == "Famous People" )
        XCTAssert( lines[2] == "   Name     Age    Occupation  ")
        XCTAssert( lines[3] == "--------------------------------")
        XCTAssert( lines[4] == "   Aaron     50     Engineer   ")
        XCTAssert( lines[5] == "  Beatrix    10     Engineer   ")
        XCTAssert( lines[6] == "    Lee      47     Financial  ")
        XCTAssert( lines[7] == "================================")
        
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
