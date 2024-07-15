//
//  ManagedArray.swift
//
//
//  Created by Aaron Nance on 7/15/24.
//

public protocol Archivable: Codable, Equatable { }

public class ManagedArray<Element: Archivable> {
    
    public private(set) var values = Array<Element>()
    
    private var file: String
    private var dir: String
    
    public init(fromFile file: String, 
                inSubDir dir: String) {
        
        self.file   = file
        self.dir    = dir
        
        values = CodableArchiver.unarchive(file: file, inSubDir: dir)
                ?? Array<Element>()
        
    }
    
    
    /// Appends `newElement` and calls `save()`
    /// - Parameter newElement: element to append
    ///
    /// - important: Because the underlying data is saved after each append call,
    /// for groups of appends prefer using `append(contentsOf:)` which only calls
    /// `save()` after all elements have been appended.
    public func append(_ newElement: Element) {
        
        values.append(newElement)
        
        save()
        
    }

    /// Appends `contentsOf` the calls `save()` once at the end.
    /// - Parameter contentsOf: elements to append.
    public func append(contentsOf: [Element]) {
        
        values.append(contentsOf: contentsOf)
        
        save()
        
    }
    
    public var count: Int { values.count }
    
    public var last:   Element? { values.last }
    
    public var first:  Element? { values.first }
    
    public func sort(_ using: (Element, Element) -> Bool) {
        
        values.sort(by: using)
        
    }
    
    //Removes all elements from the array.
    public func removeAll() {
        
        // Delete
        values.removeAll()
        
        // Save
        save()
        
    }
    
    /// Archives this `ManagedArray` to file.
    private func save() {
        
        CodableArchiver.archive(values,
                                toFile:     file,
                                inSubDir:   dir)
        
    }
    
    public static func +(lhs: ManagedArray<Element>,
                  rhs: [Element]) -> [Element] {
        
        lhs.values + rhs
        
    }
    
    public static func ==(lhs: ManagedArray<Element>, rhs: ManagedArray<Element>) -> Bool {
        
        lhs.values == rhs.values
        
    }
    
}
