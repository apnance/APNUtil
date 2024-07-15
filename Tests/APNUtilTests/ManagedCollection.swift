//
//  ManagedCollection.swift
//  
//
//  Created by Aaron Nance on 5/25/24.
//

import Foundation

import XCTest
import APNUtil

struct  Greeble: Manageable, CustomStringConvertible, Equatable {
    
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
    
    var archetypalNameToID: [String: ManagedID?] = ["Bea" : nil,
                                                    "Lee" : nil,
                                                    "Aaron" : nil,
                                                    "Winston" : nil,
                                                    "Kitsune" : nil,
                                                    "Scratch" : nil,
                                                    "Steve" : nil]
    
    override func setUpWithError() throws {
        
        // Reset
        managed.reset()
        
        XCTAssert(managed.currentEntry == nil)
        XCTAssert(managed.count == 0)
        
        // Re-build
        let archetypalNames = archetypalNameToID.keys.sorted{ $0 < $1 }
        
        for name in archetypalNames {
            
            var greeb = Greeble(name: name)
            
            managed.addEntry(&greeb,
                             allowDuplicates: false,
                             shouldArchive: false)
            
            XCTAssert(greeb.isManaged)
            
            archetypalNameToID[greeb.name] = greeb.managedID
            
        }
        
        managed.save()
        
        
        for (name, managedID) in archetypalNameToID {
            
            assert(managedID != nil)
             print("Greeble: \(name) - ID: \(managedID!)")
            
        }
        
        assert(managed.values.count == archetypalNameToID.count,
               "Managed collection size[\(managed.count)] does not match expected[\(archetypalNameToID.count)]")
        
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
        
        for newGreeble in greebles {
            
            for managedGreeble in managed.values {
                
                XCTAssert(managedGreeble.name != newGreeble.name)
                
            }
            
        }
        
        var expectedCount   = archetypalNameToID.count
        var actualCount     = managed.count
        XCTAssert(expectedCount == actualCount, "managed count error: Expected: \(expectedCount) - Actual: \(actualCount)")
        
        let mIDs: [Int?]    = managed.add(greebles)
        expectedCount       = managed.count
        actualCount         = archetypalNameToID.count + greebles.count
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
    
    func testAddEntriesNoDupes() {
        
        var greebles = buildGreebles(["Frank", "Frank", "Zappa", "Zappa", "Howard", "Jones"])
        
        var expectedCount   = archetypalNameToID.count
        var actualCount     = managed.count
        XCTAssert(expectedCount == actualCount,
                  "managed count error: Expected: \(expectedCount) - Actual: \(actualCount)")
        
        managed.addEntries(&greebles,
                           allowDuplicates: false)
        
        expectedCount       = archetypalNameToID.count + greebles.uniques
        actualCount         = managed.count
        XCTAssert(expectedCount == actualCount,
                  "managed count error: Expected: \(expectedCount) - Actual: \(actualCount)")
        
        for greeble in greebles {
            
            XCTAssert(greeble.isManaged, "\(greeble) is not managed.")
            
            XCTAssertNotNil(managed.entryFor(greeble.managedID!), "No entry found for managedID \(greeble)")
            
        }
        
        // Dupes?
        let archivedNames = managed.values.map{ $0.name }
        XCTAssert(archivedNames.allUniques)
        XCTAssert(managed.values.allUniques)
        
        
    }
    
    
    func testAddEntriesAllowDupes() {
        
        var greebles = buildGreebles(["Frank", "Frank", "Zappa", "Zappa", "Howard", "Jones"])
        
        var expectedCount   = archetypalNameToID.count
        var actualCount     = managed.count
        XCTAssert(expectedCount == actualCount,
                  "managed count error: Expected: \(expectedCount) - Actual: \(actualCount)")
        
        managed.addEntries(&greebles,
                           allowDuplicates: true)
        
        expectedCount       = managed.count
        actualCount         = archetypalNameToID.count + greebles.count
        XCTAssert(expectedCount == actualCount,
                  "managed count error: Expected: \(expectedCount) - Actual: \(actualCount)")
        
        for greeble in greebles {
            
            XCTAssert(greeble.isManaged, "\(greeble) is not managed.")
            
            XCTAssertNotNil(managed.entryFor(greeble.managedID!), "No entry found for managedID \(greeble)")
            
        }
        
    }
    
    
    func testAddEntry() {
        
        let expectedCount   = archetypalNameToID.count
        let actualCount     = managed.count
        XCTAssert(expectedCount == actualCount,
                  "managed count error: Expected: \(expectedCount) - Actual: \(actualCount)")
        
        var fritz1 = Greeble(name: "Fritz")
        managed.addEntry(&fritz1,
                         shouldArchive: true)
        
        XCTAssert(managed.currentEntry == fritz1)
        XCTAssert(fritz1.isManaged)
        
        var fredo = Greeble(name: "Fredo")
        managed.addEntry(&fredo,
                         shouldArchive: true)
        
        XCTAssert(managed.currentEntry == fredo)
        XCTAssert(fredo.isManaged)
        XCTAssert(managed.currentEntry!.managedID! == fredo.managedID)
        
        var fritz2 = Greeble(name: fritz1.name)
        managed.addEntry(&fritz2,
                    allowDuplicates: false,
                    shouldArchive: true)
        
        XCTAssert(fritz1 == fritz2)
        XCTAssert(fritz2.isManaged)
        XCTAssert(managed.currentEntry!.managedID! == fritz2.managedID)
        XCTAssert(managed.currentEntry!.name == "Fritz")
        
        // Verify no dupes.
        XCTAssert(fritz2.managedID == fritz1.managedID)
        
    }
    
    
    func testEntryFor(/*_ id: ManagedID*/) {
        
        for (name, managedID) in archetypalNameToID {
            
            print("Testing: Name: \(name) - ID: \(managedID!)")
            
            XCTAssert(managed.entryFor(managedID!) != nil,
                      "No entry found for managedID \(managedID!)")
            
        }
        
        
    }
    
    func testEntriesFor(/*_ ids: [ManagedID] */) {
        
        let managedIDs      = archetypalNameToID.values.map{$0!}
        
        let managedGreebles = managed.entriesFor(managedIDs)
        
        // Check that we got the right number of managed Greebles
        XCTAssert(managedGreebles.count == archetypalNameToID.count,
                  "Count mismatch: Expected: \(archetypalNameToID.count) - Actual: \(managedGreebles.count)")
        
        let retrievedNames  = Set<String>(managedGreebles.map{ $0.name })
        
        // Did we get a Greeble for each name in archetypalNames?
        for name in archetypalNameToID.keys {
            
            XCTAssert(retrievedNames.contains(name))
            
        }
        
    }
    
    public func testSetCurrent(/*_ id: ManagedID*/) {
        
        for managedID in archetypalNameToID.values {
            
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
    
    
    /// Same as `testSetCurrent` using newer `addEntry()` in lieu of `add()`
    public func testSetCurrentNew(/*_ id: ManagedID*/) {
        
        for managedID in archetypalNameToID.values {
            
            let managedID = managedID!
            
            XCTAssert(managed.setCurrent(managedID), "ManagedCollection had no entry for managedID '\(managedID)'")
            
            let currentManagedID = managed.currentEntry!.managedID!
            
            XCTAssert(currentManagedID == managedID)
            
        }
        
        // Fritz
        var fritz1 = Greeble(name: "Fritz")
        
        managed.addEntry(&fritz1,
                         shouldArchive: true)
        
        XCTAssert(managed.currentEntry!.managedID! == fritz1.managedID)
        
        managed.addEntry(&fritz1,
                         shouldArchive: true)
        
        // Fredo
        var fredo = Greeble(name: "Fredo")
        managed.addEntry(&fredo,
                         shouldArchive: true)
        
        XCTAssert(managed.currentEntry!.managedID! == fredo.managedID)
        
        // Fritz, Again!
        var fritz2 = Greeble(name: "Fritz")
        
        managed.addEntry(&fritz2,
                         allowDuplicates: false,
                         shouldArchive: true)
        
        XCTAssert(managed.currentEntry!.managedID! == fritz2.managedID)
        
        XCTAssert(fritz1.managedID == fritz2.managedID)
        
        XCTAssert(fritz1 == fritz2)
        
    }
    
    func testDelete(/*_ entry: Entry*/)  {
        
        // Try deleting unmanaged
        XCTAssertFalse(managed.delete(Greeble(name:"Quazibono")))
        
        XCTAssert(managed.count == archetypalNameToID.count)
        
        for entry in managed.values {
            
            managed.delete(entry)
            
        }
        
        XCTAssert(managed.count == 0)
        
        // George
        var george1 = Greeble(name: "GeorgeJetson")
        managed.addEntry(&george1, shouldArchive: true)
        
        XCTAssert(managed.count == 1)
        
        var george2 = Greeble(name: "GeorgeJetson")
        
        XCTAssert(george1 == george2)
        
        managed.addEntry(&george2,
                         allowDuplicates: false,
                         shouldArchive: true)
        XCTAssert(managed.count == 1)
        
        XCTAssert(george1 == george2)
        
        var george3 = Greeble(name: "GeorgeJetson")
        managed.addEntry(&george3,
                         allowDuplicates: true,
                         shouldArchive: true)
        XCTAssert(managed.count == 2)
        
        // Jane
        var jane = Greeble(name: "Fonda")
        managed.addEntry(&jane, shouldArchive: true)
        XCTAssert(managed.count == 3)
        
        XCTAssert(george1.managedID == george2.managedID)
        XCTAssert(george2.managedID != george3.managedID)
        
        managed.delete(george1)
        XCTAssert(managed.count == 2)
        
        managed.delete(george2)
        XCTAssert(managed.count == 2)
        
        managed.delete(george3)
        XCTAssert(managed.count == 1)
        
        managed.delete(jane)
        
        XCTAssert(managed.count == 0)
        
    }
    
    func testReset() {
        
        var expectedCount   = 7
        var actualCount     = managed.count
        XCTAssert(expectedCount == actualCount, "Expected: \(expectedCount) - Actual: \(actualCount)")
        
        managed.reset()
        
        expectedCount   = 0
        actualCount     = managed.count
        XCTAssert(expectedCount == actualCount, "Expected: \(expectedCount) - Actual: \(actualCount)")
        
    }
    
}
