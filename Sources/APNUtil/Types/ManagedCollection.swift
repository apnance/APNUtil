//
//  ManagedDictionary.swift
//  RoriQuiz
//
//  Created by Aaron Nance on 11/19/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import Foundation

public typealias ManagedID = Int

public protocol Manageable: Codable & Hashable {
    
    /// ID used by a `ManagedCollection` to for the storage/retrieval of managed `Entry`s.
    /// This can be used by clients of `ManagedCollection` to retrieve managed`Entry`s.
    /// - important: do not assign to this property;  assigment is handled by `ManagedCollection`
    var managedID: ManagedID? { get set }
    
}

public extension Manageable {
    
    var isManaged: Bool { managedID != nil }
    
}

/// A class that stores entries in an `[ManagedID:Entry]` `Dictionary` archiving the collection upon
/// each change.   Adding `Entry`s assigns them an `ManagedID` that may be used for later retrieval.
/// - important: `Entry`'s `managedID` should be assigned to only by `ManagedCollection`.
public class ManagedCollection<Entry>: Codable where Entry: Manageable {
    
    // MARK: - Properties
    /// `[ManagedID:Entry]` ` Dictionary` responsible for storing/retrieving `Entry`s
    private var managed = [ManagedID : Entry]()
    
    public var values: [Entry] { Array(managed.values) }
    
    /// Count of all managed `Entry`s
    public var count: Int { managed.values.count }
    
    /// File name under which the `ManagedCollection` will be archived
    private let archiveName: String
    
    /// Sub directory name under which the `ManagedCollection` will be archived
    private let archiveDirectory: String
    
    /// `ManagedID` assigned to the most recently added `Entry`.
    /// - important: Should only read/written to by `getNextUsableID()`
    private var lastAssignedID: ManagedID = 0
    
    /// `ManagedID` for the most recently added `Entry`.
    private(set) var currentID: ManagedID?
    
    /// Most recently added `Entry`
    public var currentEntry: Entry? { entryForCurrent() }
    
    
    // MARK: - Overrides
    /// Use factory method load(file: inSubDir:) for instantiation.
    private init(file fileName: String, inSubDir dirName: String ) {
        
        archiveName = fileName
        archiveDirectory = dirName
        
    }
    
    
    // MARK: - Custom Methods
    /// Adds/Updates an `Array` of `[Entry]` to `managed`.  `Entry`s  not already
    /// managed(i.e. `managedID == nil`) are assigning
    /// a unique `ManagedID`, `Entry`'s already assigned `ManagedID` update/overwrite the `Entry`
    /// associated with that `ManagedID`.
    /// This method returns an `Array` of  the`ManagedID`s associated with the added/updated `Entry`s.
    ///
    /// - parameters:
    ///     - entries: `Entry` values to add-to/update-in`managed`
    ///     - allowDuplicates: `Bool` to suppress/allow the addition of duplicate `Entry`
    ///     values(i.e. same `Entry` values with different `ManagedIDs`
    ///
    
    /// - important: passing`Entry` values that have already been assigned `ManagedID`s results
    /// in overwrites for those `ManagedID`s.
    /// - important: the returned `ManagedID`s are keys used for retrieving the `Entry`s from the
    /// `ManagedCollection`
    ///
    /// - returns: An array of `ManagedID`s assigned to the added `Entry`s
    @available(*, deprecated, message: "use addEntries(:)")
    @discardableResult public func add(_ entries: [Entry],
                                       allowDuplicates: Bool = false) -> [ManagedID] {
        
        var returnIDs = [ManagedID]()
        
        for entry in entries {
            
            let id = add(entry,
                         allowDuplicates: allowDuplicates,
                         shouldArchive: false)
            
            returnIDs.append(id)
            
        }
        
        // Handle dupes
        if !allowDuplicates { returnIDs = returnIDs.dedupe() }
        
        save()
        
        return returnIDs
        
    }
    
    /// Adds/Updates an `Entry` to `managed` then calls save() if `shouldArchive` is `true`.
    ///
    /// - parameters:
    ///     - entry: `Entry` value to add-to/update-in`managed`
    ///     - allowDuplicates: `Bool` to suppress/allow the addition of duplicate `Entry`
    ///     values(i.e. same `Entry` values with different `ManagedIDs`
    ///     - shouldArchive: `Bool` to suppress/allow the archival of the `ManagedCollection`
    ///
    /// - important: passing an `Entry` with an ID found in `managed` results in an update/overwrite
    /// for that ID.
    @available(*, deprecated, message: "use addEntry(:)")
    @discardableResult public func add(_ entry: Entry,
                                       allowDuplicates: Bool = false,
                                       shouldArchive: Bool) -> ManagedID {
        
        /// Finds or generates a ManagedID for the provided Entry.  Does not all
        func idFor(_ entry: Entry) -> ManagedID {
            
            // 1. Is `Entry` already managed? - If yes re-use it's ID.
            if let id = entry.managedID { return id /*EXIT*/ }
            
            // 2. Is there already a matching `Entry` and if so do we allow
            // duplicates?
            if !allowDuplicates {
                
                for (key, value) in managed {
                    
                    if value == entry { return key /*EXIT*/ }
                    
                }
                
            }
            
            // 3. Find and return next unused ID
            while true {
                
                if managed[lastAssignedID] == nil {
                    
                    return lastAssignedID /*EXIT*/
                    
                }
                
                lastAssignedID += 1
                
            }
            
        }
        
        var entry = entry
        
        // ID
        entry.managedID = idFor(entry)
        
        // Set as current
        currentID = entry.managedID
        
        // Add/update
        managed[entry.managedID!] = entry
        
        // Save?
        if shouldArchive { save() }
        
        return entry.managedID!
        
    }
    
    // MARK: - Custom Methods
    /// Adds/Updates an `Array` of `[Entry]` to `managed`.  `Entry`s  not already
    /// managed(i.e. `managedID == nil`) are assigned a unique `ManagedID`,
    /// `Entry`'s already assigned `ManagedID` update/overwrite the `Entry`
    /// associated with that `ManagedID`.
    ///
    /// - parameters:
    ///     - entries:  inout parameter `Entry` values to add-to/update-in`managed`,
    ///     the ManagedID value of this inout parameter will be set.
    ///     - allowDuplicates: `Bool` to suppress/allow the addition of duplicate `Entry`
    ///     values(i.e. same `Entry` values with different `ManagedIDs`
    ///
    /// - important: passing`Entry` values that are already managed results
    /// in overwriting currently stored value.
    ///
    /// - returns: An array of `ManagedID`s assigned to the added `Entry`s
    public func addEntries(_ entries: inout [Entry],
                                       allowDuplicates: Bool = false) {
        
        for i in 0...entries.lastUsableIndex {
            
            addEntry(&entries[i],
                     allowDuplicates: allowDuplicates,
                     shouldArchive: false)
            
        }
        
        save() // Archive Once
        
    }
    
    /// Adds/Updates an `Entry` to `managed` then calls save() if `shouldArchive` is `true`.
    ///
    /// - parameters:
    ///     - entry: `Entry` value to add-to/update-in`managed`
    ///     - allowDuplicates: `Bool` to suppress/allow the addition of duplicate `Entry`
    ///     values(i.e. same `Entry` values with different `ManagedIDs`
    ///     - shouldArchive: `Bool` to suppress/allow the archival of the `ManagedCollection`
    ///
    /// - important: passing an already managed `Entry` with an ID found in `managed` results in an update/overwrite
    public func addEntry(_ entry: inout Entry,
                         allowDuplicates: Bool = false,
                         shouldArchive: Bool) {
        
        /// Finds or generates a ManagedID for the provided Entry.
        func idFor(_ entry: Entry) -> ManagedID {
            
            // 1. Is `Entry` already managed? - If yes re-use it's ID.
            if let id = entry.managedID { return id /*EXIT*/ }
            
            // 2. Is there already a matching `Entry` and if so do we allow
            // duplicates?
            if !allowDuplicates {
                
                for (key, value) in managed {
                    
                    if value == entry { return key /*EXIT*/ }
                    
                }
                
            }
            
            // 3. Find and return next unused ID
            while true {
                
                if managed[lastAssignedID] == nil {
                    
                    return lastAssignedID /*EXIT*/
                    
                }
                
                lastAssignedID += 1
                
            }
            
        }
        
        // ID
        entry.managedID = idFor(entry)
        
        // Set as current
        currentID = entry.managedID
        
        // Add/update
        managed[entry.managedID!] = entry
        
        // Save?
        if shouldArchive { save() }
        
    }
    
    /// Attempts to delete specified `Entry` from `managed`.
    /// - returns: a discaradable `Bool` indicating whether or not the `Entry` was found/deleted.
    @discardableResult public func delete(_ entry: Entry) -> Bool {
        
        if let key = entry.managedID {
            
            if managed.removeValue(forKey: key) != nil {
                
                save()
                return true /*EXIT*/
                
            }
            
        }
        
        return false /*EXIT*/
        
    }
    
    /// Reverts to empty starting state ready to be re-used.
    ///
    /// - note: this deletes all entries and resets the id counter.
    public func reset() {
        
        // Delete
        managed.removeAll()
        
        // Reset
        lastAssignedID  = 0
        currentID       = lastAssignedID
        
        // Save
        save()
        
    }
    
    /// Returns the `Entry` associated with the specified  `ManagedID`
    public func entryFor(_ id: ManagedID) -> Entry? {
        
        currentID = id
        
        return managed[id]
        
    }
    
    /// Returns an `Array` of `[Entry]` for all specified `ManagedID`s
    public func entriesFor(_ ids: [ManagedID] ) -> [Entry] {
        
        var entries = [Entry]()
        
        for id in ids {
            
            if let entry = entryFor(id) { entries.append(entry) }
            
        }
        
        return entries
        
    }
    
    /// Returns the `Entry` associated with the `currentID` or `nil` if `currentID` is `nil`
    private func entryForCurrent() -> Entry? {
        
        if let currentID = currentID { return managed[currentID] /*EXIT*/ }
        else { return nil /*EXIT*/ }
        
    }
    
    /// Attempts to set the `currentID`.  Method fails if the specified `id` is not
    /// a valid(i.e. currently used) ManagedID.
    /// - returns: Bool indicating success.
    public func setCurrent(_ id: ManagedID) -> Bool {
        
        if entryFor(id) == nil {
            
            return false /*EXIT*/
            
        } else {
            
            currentID = id
            return true /*EXIT*/
            
        }
        
    }
    
    // MARK: - Archival
    /// Factory method for loading an instance of `ManagedCollection` from archive.  If no archive
    /// exists a new `ManagedCollection<Entry>` is returned instead.
    public static func load(file: String,
                            inSubDir dir: String ) -> ManagedCollection<Entry> {
        
        return  CodableArchiver.unarchive(file: file, inSubDir: dir)
        ?? ManagedCollection<Entry>(file: file, inSubDir: dir)
        
    }
    
    /// Archives this `ManagedCollection` to file.
    public func save() {
        
#if DEBUG
        print("\(#function): \(type(of: self))")
#endif
        
        CodableArchiver.archive(self,
                                toFile: archiveName,
                                inSubDir: archiveDirectory)
        
    }
    
}
