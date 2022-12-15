//
//  Queue.swift
//  Nodels
//
//  Origin: https://algs4.cs.princeton.edu/code/edu/princeton/cs/algs4/LinkedQueue.java.html
//  Copyright 2002-2022, Robert Sedgewick and Kevin Wayne.
//  Translated into Swift by Aaron Nance on 12/12/22.
//

import Foundation

// TODO: Clean Up - Move Queue to APNUtil
public class Queue<Item: Equatable> {
    
    private var first: Linked?          // beginning of queue
    private var last: Linked?           // end of queue
    
    public private (set) var count: Int // number of elements on queue
    public var isEmpty: Bool { first == nil; }
    
    // helper linked list class
    class Linked: Equatable {
        
        static func == (lhs: Queue<Item>.Linked,
                        rhs: Queue<Item>.Linked) -> Bool {
            
            lhs.item == rhs.item
            && lhs.next == rhs.next
            
        }
        
        
        fileprivate var item: Item
        fileprivate var next: Linked?
        
        init(item: Item, next: Linked?) {
            
            self.item = item
            self.next = next
        }
        
    }

    public init() {
        
        first   = nil;
        last    = nil;
        count   = 0;
        
        assert(check())
        
    }
    
    /// Initialies a new `Queue` using `from` `Array` as the base with the first `Item`  in `Array` being
    /// the first item in `Queue` and the last `Item` in the `Array` being the last `Item` in the `Queue`
    public convenience init(from: [Item]) {
        
        self.init()
        
        for item in from {
            
            enqueue(item: item)
            
        }
        
    }
    
    /// Returns the item least recently added to this queue.
    public func peek() -> Item? { first?.item }
    
    /// Enqueues items in array in the order of the array.
    public func enqueue(items: [Item]) { items.forEach { enqueue(item: $0) } }
    
    
    public func enqueue(item: Item) {
        
        let oldLast = last
        
        last = Linked(item: item, next: nil);
        
        if (isEmpty) { first = last }
        else { oldLast?.next = last }
        
        count += 1
        
        assert(check())
        
    }

    /// Removes and returns the least recently added item on this `Queue`
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

    // TODO: Clean Up - translate toString as CustomStringConveritble description variable.
    /**
     * Returns a string representation of this queue.
     * @return the sequence of items in FIFO order, separated by spaces
     */
//    public String toString() {
//        StringBuilder s = new StringBuilder();
//        for (Item item : this)
//            s.append(item + " ");
//        return s.toString();
//    }

    // check internal invariants
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

        return true;
    }

    // TODO: Clean Up - Make Queue adopt Sequence? or Iterable?
// TODO: Clean Up - delete?
//    /**
//     * Returns an iterator that iterates over the items in this queue in FIFO order.
//     * @return an iterator that iterates over the items in this queue in FIFO order
//     */
//    public Iterator<Item> iterator()  {
//        return new LinkedIterator();
//    }
//
//    // an iterator, doesn't implement remove() since it's optional
//    private class LinkedIterator implements Iterator<Item> {
//        private Linked current = first;
//
//        public boolean hasNext()  { return current != nil;                     }
//        public void remove()      { throw new UnsupportedOperationException();  }
//
//        public Item next() {
//            if (!hasNext()) throw new NoSuchElementException();
//            Item item = current.item;
//            current = current.next;
//            return item;
//        }
//    }
//
//
//    /**
//     * Unit tests the {@code LinkedQueue} data type.
//     *
//     * @param args the command-line arguments
//     */
//    public static void main(String[] args) {
//        LinkedQueue<String> queue = new LinkedQueue<String>();
//        while (!StdIn.isEmpty()) {
//            String item = StdIn.readString();
//            if (!item.equals("-"))
//                queue.enqueue(item);
//            else if (!queue.isEmpty())
//                StdOut.print(queue.dequeue() + " ");
//        }
//        StdOut.println("(" + queue.size() + " left on queue)");
//    }
}

