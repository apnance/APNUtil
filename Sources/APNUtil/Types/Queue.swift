//
//  Queue.swift
//  Nodels
//
//  Origin: https://algs4.cs.princeton.edu/code/edu/princeton/cs/algs4/LinkedQueue.java.html
//  Copyright 2002-2022, Robert Sedgewick and Kevin Wayne.
//  Swift translation by Aaron Nance on 12/12/22.
//

import Foundation

public class Queue<Item: Equatable> {
    
    private var first: Linked?          // beginning of Queue
    private var last: Linked?           // end of Queue
    
    public private (set) var count = 0  // number of elements on Queue
    public var isEmpty: Bool { first == nil; }
    
    public init() { assert(check()) }
    
    /// Initializes a new `Queue` using `from` `Array` as the base with the first `Item`  in `Array` being
    /// the first item in `Queue` and the last `Item` in the `Array` being the last `Item` in the `Queue`
    public convenience init(from: [Item]) {
        
        self.init()
        
        for item in from {
            
            enqueue(item: item)
            
        }
        
    }
    
    /// Returns the `Item` least recently enqueued.
    public func peek() -> Item? { first?.item }
    
    /// Enqueues each `Item` in `items` in the order of the `items` array.
    public func enqueue(items: [Item]) { items.forEach { enqueue(item: $0) } }
    
    /// Places `item` last in `Queue`.
    public func enqueue(item: Item) {
        
        let oldLast = last
        
        last = Linked(item: item, next: nil);
        
        if (isEmpty) { first = last }
        else { oldLast?.next = last }
        
        count += 1
        
        assert(check())
        
    }
    
    /// Enqueues`item` if it is not currently in the `Queue`
    public func enqueueUnique(item: Item) {
        
        if !contains(item) { enqueue(item: item) }
        
    }

    /// Steps through `items` enqueueing any that are not currently in the `Queue`.
    public func enqueueUnique(items: [Item]) {
        
        for item in items { enqueueUnique(item: item) }
        
    }
    
    /// Removes and returns the least recently added item on this `Queue`.
    @discardableResult public func dequeue() -> Item? {
        
        let item = first?.item
        
        first = first?.next;
        count -= 1;
        
        if (isEmpty) {
            
            count   = 0
            last    = nil
            
        }   // to avoid loitering
        
        assert(check())
        
        return item
        
    }
    
    // Check internal invariants.
    private func check() -> Bool {
        if (count < 0) {
            return false;
        }
        else if (count == 0) {
            if (first != nil) { return false }
            if (last  != nil) { return false }
        }
        else if (count == 1) {
            if (first == nil || last == nil) { return false }
            if (first != last)                 { return false }
            if (first?.next != nil)            { return false }
        }
        else {
            if (first == nil || last == nil) { return false }
            if (first == last)      { return false }
            if (first?.next == nil) { return false }
            if (last?.next  != nil) { return false }
            
            // check internal consistency of instance variable n
            var numberOfLinkeds = 0
            
            var current = first
            
            while current != nil {
                
                numberOfLinkeds += 1
                current = current?.next
                
            }
            
            if (numberOfLinkeds != count) { return false /*EXIT*/ }
            
            // check internal consistency of instance variable last
            var lastLinked = first
            
            while (lastLinked?.next != nil) { lastLinked = lastLinked?.next }
            
            if (last != lastLinked) { return false /*EXIT*/ }
            
        }
        
        return true
        
    }
    
    // helper linked list class
    fileprivate class Linked: Equatable {
        
        static func == (lhs: Queue<Item>.Linked,
                        rhs: Queue<Item>.Linked) -> Bool {
            
            lhs.item == rhs.item &&
            lhs.next == rhs.next
            
        }
        
        fileprivate var item: Item
        fileprivate var next: Linked?
        
        init(item: Item, next: Linked?) {
            
            self.item = item
            self.next = next
        }
        
    }
    
}

extension Queue: Sequence {
    
    public typealias Iterator = QueueIterator
    
    public var underestimatedCount: Int { count }
    
    public func makeIterator() -> QueueIterator { QueueIterator(first: first) }
    public struct QueueIterator: IteratorProtocol {
        
        private var nextLinked: Linked?
        
        fileprivate init(first: Linked? ) { nextLinked = first }
        
        mutating public func next() -> Item? {
            
            let nextItem    = nextLinked?.item
            nextLinked      = nextLinked?.next
            
            return nextItem /*EXIT*/
            
        }
        
    }
    
}

extension Queue: CustomStringConvertible {
    
    public var description: String {
        
        reduce("") { $0 == "" ? "\($1)" : "\($0), \($1)" }
        
    }
    
}
