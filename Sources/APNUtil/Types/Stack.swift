//
//  Stack.swift
//  APNUtil
//
//  Created by Aaron Nance on 8/6/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

public struct Stack<Element: Equatable> {
    
    // MARK: - Properties
    public private(set) var data = Array<Element>()
    public var isEmpty: Bool { data.isEmpty }
    public var count: Int { data.count }
    
    
    // MARK: - Initializers
    public init(with data: [Element]?) { self.data = data ?? [] }
    public init(_ data: Element...) { data.forEach { push($0) } }
    
    
    // MARK: - Methods
    public mutating func push(_ datum: Element) { data.append(datum) }
    @discardableResult public mutating func pop() -> Element? { data.popLast() }
    public func peek() -> Element? { data.last }
    
    /// Pushes `datum` onto `Stack` if `datum != peek()`
    public mutating func pushNew(_ datum: Element) {
        
        if datum != peek() { push(datum) }
        
    }
    
    /// Removes the last `Element` then returns a copy of the new last `Element`
    public mutating func popPeek() -> Element? { pop(); return peek() }
    
}
