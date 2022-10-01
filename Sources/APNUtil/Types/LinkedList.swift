//
//  LinkedList.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/7/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

public class LinkedList<T: CustomStringConvertible> {
    
    fileprivate var first: Node<T>?
    fileprivate var last: Node<T>?
    
    /// Returns the number of elements contained in the list.
    private var _count = 0
    public var count: Int { return _count }

    public init() { }
    
    public init(_ value: T) { addFirst(value) }
    
    public init(_ values: [T]) {
        
        for val in values { addLast(val) }
        
    }
    
    /// Appends value to start of the list.
    public func addFirst(_ value: T) {
        
        let node    = Node<T>(value: value)
        node.next   = first
        
        first       = node
        
        if last == nil { last = node }
        
        _count += 1
        
    }
    
    /// Appends value to end of the list.
    public func addLast(_ value: T) {
        
        let node = Node<T>(value: value)
        last?.next = node
        
        last = node
        
        if first == nil { first = node }
        
        _count += 1
        
    }
    
    /// Removes and returns the first element.
    @discardableResult public func removeFirst() -> T? {
        
        let value   = first?.value
        let next    = first?.next
        first       = nil
        first       = next
        
        if first == nil { last = nil }
        if count > 0 { _count -= 1 }
        
        return value
        
    }
    
    /// Removes and returns the last element.
    /// - warning: takes time propotional to count
    @discardableResult public func removeLast() -> T? {
        
        let value   = last?.value
        
        if first?.next == nil {
            
            first   = nil
            last    = nil
            
            _count   = 0
            
            return value /*EXIT*/
            
        }
        
        var next    = first
        
        while next?.next?.next != nil { next = next?.next }
        
        last        = nil
        last        = next
        last?.next  = nil
                
        _count -= 1
        
        return value
        
    }
    
    public func peekFirst()    -> T? { first?.value }
    public func peekLast()     -> T? { last?.value }
    
}

extension LinkedList : CustomStringConvertible {
    
    public var description: String {
        
        var node = first
        var desc = ""
        
        while(node != nil) {
            
            desc += "\(node!.value)"
            
            node = node?.next
            
            if node != nil { desc += "->" }
            
        }
        
        return desc
        
    }
    
}

private class Node<T: CustomStringConvertible> : CustomStringConvertible {
        
    fileprivate(set) var next: Node<T>?
    
    let value: T
    
    init(value: T) { self.value = value }
    
    var description: String { value.description }
    
}
