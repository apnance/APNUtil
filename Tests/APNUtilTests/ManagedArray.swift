//
//  ManagedArray.swift
//  
//
//  Created by Aaron Nance on 7/15/24.
//

import XCTest
import APNUtil

struct  Nurny: Archivable, CustomStringConvertible {
    
    var name: String
    
    var description: String { "A Nurny Named \(name)!"}

    init(name: String) { self.name = name }
    
    static func ==(lhs: Nurny, rhs: Nurny ) -> Bool {
        lhs.name == rhs.name
    }
    
    static func < (lhs: Nurny, rhs: Nurny) -> Bool {
        lhs.name < rhs.name
    }

    
}

final class ManagedArray: XCTestCase {
    
    let managed = APNUtil.ManagedArray<Nurny>(fromFile: "NurnyTest",
                                              inSubDir: "Nurnies")
    
    var archetypalNames: [String] = ["Bea",
                                     "Lee",
                                     "Aaron",
                                     "Winston",
                                     "Kitsune",
                                     "Scratch",
                                     "Steve"]
    
    var moreNames = [Nurny(name: "Henry"),
                     Nurny(name: "Buck"),
                     Nurny(name: "Clyde"),
                     Nurny(name: "Bonnie")]
    
    override func setUpWithError() throws {
        
        // Reset
        managed.removeAll()
        
        XCTAssert(managed.count == 0)
        
            archetypalNames.forEach{ managed.append(Nurny(name: $0)) }
        
        assert(managed.count == archetypalNames.count,
               "Managed collection size[\(managed.count)] does not match expected[\(archetypalNames.count)]")
        
    }
    
    func testAppend() {
        
        var expectedCount = archetypalNames.count
        XCTAssert(managed.count == expectedCount)
        
        managed.append(Nurny(name: "Lucas"))
        expectedCount += 1
        XCTAssert(managed.count == expectedCount)
        
        managed.append(Nurny(name: "Jimbo"))
        expectedCount += 1
        XCTAssert(managed.count == expectedCount)
        
        
    }
    
    func testAppendContentsOf() {
        
        let unmanaged = [Nurny(name: "Bill"), Nurny(name: "Wayne") ]
        
        XCTAssert(managed.count == archetypalNames.count)
        
        print(managed.values.asCommaSeperatedString(conjunction: "&"))
        
        managed.append(contentsOf: unmanaged)
        
        print(managed.values.asCommaSeperatedString(conjunction: "&"))
        
        XCTAssert(managed.count == archetypalNames.count + unmanaged.count)
        
    }
    
    
    func testCount() {
        
        XCTAssert(managed.count == archetypalNames.count)
        
        managed.append(Nurny(name: "Jeff"))
        
        XCTAssert(managed.count == archetypalNames.count + 1)
        
        managed.removeAll()
        
        XCTAssert(managed.count == 0)
        
        
    }
    
    func testFirst() {
        
        XCTAssert(managed.first!.name == "Bea")
        
        managed.sort{ $0.name < $1.name }
        
        XCTAssert(managed.first!.name == "Aaron")
        
    }
    
    func testLast() {
        
        XCTAssert(managed.last!.name == "Steve")
        
        managed.sort{ $0.name < $1.name }
        
        XCTAssert(managed.last!.name == "Winston")
        
    }
    
    func testSort() {
        
        XCTAssert(managed.first!.name == "Bea")
        XCTAssert(managed.last!.name == "Steve")
        
        managed.sort{ $0.name < $1.name }
        
        XCTAssert(managed.values.map{ $0.name } == archetypalNames.sorted())
        
        XCTAssert(managed.first!.name == "Aaron")
        XCTAssert(managed.last!.name == "Winston")
        
        managed.removeAll()
        XCTAssert(managed.count == 0)
        
        managed.sort{$0.name < $1.name}
        let emptyNurnies = APNUtil.ManagedArray<Nurny>(fromFile: "", inSubDir: "")
        XCTAssert(managed == emptyNurnies)
        
    }
    
    func testRemoveAll() {
        
        XCTAssert(managed.count == archetypalNames.count)
        
        managed.removeAll()
        
        XCTAssert(managed.count == 0)
        
    }
    
    func testAddOperator() {
        
        XCTAssert(managed.count == archetypalNames.count)
        
        managed.values.forEach{ print($0) }
        
        let stillMoreNames = managed + moreNames
        
        XCTAssert(stillMoreNames.count == managed.count + moreNames.count)
        
        
    }
    
        func testSave() {
            
            XCTAssert(managed.count == archetypalNames.count)
            
            // Load From managed's Saved File to Check That It Was Saved
            let loadedFromManagedsSaveFile = APNUtil.ManagedArray<Nurny>(fromFile: "NurnyTest",
                                                                         inSubDir: "Nurnies")
            
            XCTAssert(loadedFromManagedsSaveFile.count == archetypalNames.count, "\(loadedFromManagedsSaveFile.count) != \(archetypalNames.count)")
            
        }
    
}
