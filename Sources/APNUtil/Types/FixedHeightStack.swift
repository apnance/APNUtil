//
//  FixedHeightStack.swift
//  APNUtil
//
//  Created by Aaron Nance on 8/7/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

/// A stack with a fixed maximum height, pushing `Element`s onto the `Stack` that would exceed this
/// maximum height results in the removal of the oldest or lowest `Element` on the `Stack`.  The `count`
/// for this variant of `Stack` can never exceed `maxHeight`.
///
/// This struct is useful for creating e.g. and undo `Stack` that has a maximum number of undoes.
public struct FixedHeightStack<Element:Equatable> {
    
    // MARK: - Properties
    private var data = Array<Element>()
    private var maxHeight = Int.max
    public var isEmpty: Bool { data.isEmpty}
    public var count: Int { data.count }
    
    
    // MARK: - Initializers
    
    /// - important: if `data`s count exceeds maxHeight, data is `Element`s are pruned from the
    /// bottom of the `Stack` resulting in a count of `maxHeight`
    /// to match maxHeight.
    public init(maxHeight: Int, _ data: [Element]? = nil) {
        
        self.data = data ?? []
        self.maxHeight = maxHeight
        
        prune()
        
    }
    
    
    // MARK: - Methods
    public mutating func push(_ datum: Element) {
        
        data.append(datum)
        
        prune()
        
    }
    @discardableResult public mutating func pop() -> Element? { data.popLast() }
    public func peek() -> Element? { data.last }

    /// Pushes `datum` onto `Stack` if it is not equal to the current top most `Element`
    /// (i.e. `datum != peek()`)
    public mutating func pushNew(_ datum: Element) { if datum != peek() { push(datum) } }
    
    /// Removes the last `Element` then returns a copy of the new last `Element`
    public mutating func popPeek() -> Element? { pop(); return peek() }
    
    mutating private func prune() {
        
        if data.count > maxHeight {
            
            data.removeFirst(data.count - maxHeight)
       
        }
        
    }
    
}

public extension FixedHeightStack where Element: CustomStringConvertible {
    
    func describe() -> String {
        
        var description = ""
        for (i, datum) in data.enumerated() {
            
            description += "\(i).\n"
            description += datum.description
            
            if i != data.lastUsableIndex { description += "\n" }
            
        }
        
        return description /*EXIT*/
        
    }
    
}
