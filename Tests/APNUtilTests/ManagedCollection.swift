//
//  ManagedCollection.swift
//  
//
//  Created by Aaron Nance on 5/25/24.
//

import Foundation

import XCTest
import APNUtil

struct  Greeble: Managable, CustomStringConvertible, Equatable {
    
    var managedID: Int?
    var name: String
    
    var description: String { "Greeble: name:\(name) - id: \(managedID ?? -1279)"}
    
    static func ==(lhs: Greeble, rhs: Greeble ) -> Bool {
        lhs.name == rhs.name
    }
    
}

class ManagedCollection: XCTestCase {

    let managed: APNUtil.ManagedCollection<Greeble> = APNUtil.ManagedCollection.load(file: "GreebleTest",
                                                                                     inSubDir: "")
    
    var archetypalNames: [String: ManagedID?] = ["Bea" : nil,
                                                 "Lee" : nil,
                                                 "Aaron" : nil,
                                                 "Winston" : nil,
                                                 "Kitsune" : nil,
                                                 "Scratch" : nil,
                                                 "Steve" : nil]
    
    override func setUpWithError() throws {
        
        // Delete Old Entries
        for entry in managed.values {
            
            managed.delete(entry)
            
        }
        
        for name in archetypalNames.keys.sorted{$0 < $1} {
            let greeb = Greeble(name: name)
            
            archetypalNames[name] = managed.add(greeb,
                                      allowDuplicates: false,
                                      shouldArchive: false)
            
        }
        
        managed.save()
        
        
        for (name, managedID) in archetypalNames {
            
            assert(managedID != nil)
             print("Greeble: \(name) - ID: \(managedID!)")
            
        }
        
        assert(managed.values.count == archetypalNames.count,
               "Managed collection size[\(managed.count)] does not match expected[\(archetypalNames.count)]")
        
    }
    
    private func buildGreebles(_ names: [String]) -> [Greeble] {
        
        var greebs = [Greeble]()
        
        for name in names {
            
            greebs.append(Greeble(name: name))
            
        }
        
        return greebs
        
    }
    
    func testAdd() {
        
        let greebles = buildGreebles(["Frank", "Zappa", "Howard", "Jones"])
        
        var expectedCount   = managed.count
        var actualCount     = archetypalNames.count
        XCTAssert(expectedCount == actualCount, "managed count error: Expected: \(expectedCount) - Actual: \(actualCount)")
        
        let mIDs: [Int?]    = managed.add(greebles)
        expectedCount       = managed.count
        actualCount         = archetypalNames.count + greebles.count
        XCTAssert(expectedCount == actualCount, "managed count error: Expected: \(expectedCount) - Actual: \(actualCount)")
        
        for id in mIDs {
            
            XCTAssert(managed.entryFor(id!) != nil, "No entry found for managedID \(id!)")
            
        }
        
        let fritzID = managed.add(Greeble(name: "Fritz"),
                                  shouldArchive: true)
        
        XCTAssert(managed.currentEntry!.managedID! == fritzID)
        
        let fredoID = managed.add(Greeble(name: "Fredo"),
                                  shouldArchive: true)
        
        XCTAssert(managed.currentEntry!.managedID! == fredoID)
        
        let fritzID2 = managed.add(Greeble(name: "Fritz"),
                                   allowDuplicates: false,
                                   shouldArchive: true)
        
        XCTAssert(managed.currentEntry!.managedID! == fritzID2)
        XCTAssert(managed.currentEntry!.name == "Fritz")
        
        // Verify no dupes.
        XCTAssert(fritzID == fritzID2)
        
    }
    
    func testEntryFor(/*_ id: ManagedID*/) {
        
        for (name, managedID) in archetypalNames {
            
            print("Testing: Name: \(name) - ID: \(managedID!)")
            
            XCTAssert(managed.entryFor(managedID!) != nil,
                      "No entry found for managedID \(managedID!)")
            
        }
        
        
    }
    
    func testEntriesFor(/*_ ids: [ManagedID] */) {
        
        let managedIDs      = archetypalNames.values.map{$0!}
        
        let managedGreebles = managed.entriesFor(managedIDs)
        
        // Check that we got the right number of managed Greebles
        XCTAssert(managedGreebles.count == archetypalNames.count,
                  "Count mismatch: Expected: \(archetypalNames.count) - Actual: \(managedGreebles.count)")
        
        let retrievedNames  = Set<String>(managedGreebles.map{ $0.name })
        
        // Did we get a Greeble for each name in archetypalNames?
        for name in archetypalNames.keys {
            
            XCTAssert(retrievedNames.contains(name))
            
        }
        
    }
    
    public func testSetCurrent(/*_ id: ManagedID*/) {
        
        for managedID in archetypalNames.values {
            
            let managedID = managedID!
            
            XCTAssert(managed.setCurrent(managedID), "ManagedCollection had no entry for managedID '\(managedID)'")
            
            let currentManagedID = managed.currentEntry!.managedID!
            
            XCTAssert(currentManagedID == managedID)
            
            
        }
        
        let fritzID = managed.add(Greeble(name: "Fritz"),
                                  shouldArchive: true)
        
        XCTAssert(managed.currentEntry!.managedID! == fritzID)
        
        let fredoID = managed.add(Greeble(name: "Fredo"),
                                  shouldArchive: true)
        
        XCTAssert(managed.currentEntry!.managedID! == fredoID)
        
        let fritzID2 = managed.add(Greeble(name: "Fritz"),
                                   allowDuplicates: false,
                                   shouldArchive: true)
        
        XCTAssert(managed.currentEntry!.managedID! == fritzID2)
        
        XCTAssert(fritzID == fritzID2)
        
    }
    
    func testDelete(/*_ entry: Entry*/)  {
        
        // Try deleting unmanaged
        XCTAssertFalse(managed.delete(Greeble(name:"Quazibono")))
        
        XCTAssert(managed.count == archetypalNames.count)
        
        for entry in managed.values {
            
            managed.delete(entry)
            
        }
        
        XCTAssert(managed.count == 0)
        
        
        var george = Greeble(name: "GeorgeJetson")
        george.managedID = managed.add(george, shouldArchive: true)
        
        XCTAssert(managed.count == 1)
        managed.delete(george)
        
        XCTAssert(managed.count == 0)
        
    }
    
}
