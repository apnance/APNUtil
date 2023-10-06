//
//  ClosedRange.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/16/18.
//  Copyright © 2018 Aaron Nance. All rights reserved.
//

import Foundation

public extension ClosedRange where Bound == Int {

    /// Calls closure once for every number in `ClosedRange`
    func `repeat`(_ todo: () -> ()) { for _ in self { todo() } }

    /// Repeatedly calls `(Int) -> ()` passing in the number of the `ClosedRange` in ascending order.
    func `repeat`(_ todo: (Int) -> ()) { for i in self { todo(i) } }

    var sum: Int { reduce(0){ $0 + $1 } }
    
    enum ResolutionType {
        
        case LowerBound
        case LowerBoundNonZero
        case UpperBound
        case UpperBoundNonZero
        case Random
        case RandomIntersecting(Set<Int>)
        
    }
    
    var lowerBoundNonZero: Int {
        
        if lowerBound != 0 {
            
            return lowerBound /*EXIT*/
            
        } else if contains(1) {
            
            return 1 /*EXIT*/
            
        }
        
        fatalError("Range is 0...0 but non-zero value is required.")
        
    }
    
    /// Returns the highest value in the `ClosedRange` that is not zero.
    /// 
    /// # Example #
    /// ```swift
    /// // e.g.
    /// let upper1 = (-100...0).upperBoundNonZero   // upper equals -1
    ///
    /// let upper2 = (-1...0).upperBoundNonZero     // upper equals -1
    ///
    /// let upper3 = (-100...15).upperBoundNonZero  // upper equals 15
    ///
    /// let upper4 = (2...15).upperBoundNonZero     // upper equals 15
    /// ```
    /// - important: (0...0).upperBoundNonZero returns -1
    var upperBoundNonZero: Int {
        
        assert(!(upperBound == 0 && lowerBound == 0), "Range is 0...0 but non-zero value is required.")
        
        return ( upperBound != 0 ) ? upperBound : -1
        
    }
    
    func random() -> Int { Int.random(in: self) }
    
    /// Attempts to return a random element from the values held in common between the `ClosedRange` and the provided `Set<Int>`
    /// - note: Returns nil if the there are no common Int shared between the `Set<Int>` and this `ClosedRange`
    func randomIntersecting(_ set: Set<Int>) -> Int? {
        var intersecting = Set<Int>()
        
        set.forEach {
            
            if self.contains($0) {
                
                intersecting.insert($0)
                
            }
            
        }
        
        return intersecting.randomElement()
        
    }
    
    /// Converts a Range to one an Int value according to the speciifed `ResolutionType`
    ///
    /// ex. 1:  `(-10...19).resolveTo(.LowerBound)` returns -10
    ///
    /// ex. 2:  `(-10...19).resolveTo(.Random)` returns a random Int value between -10 and 19.
    func resolveTo(_ rType: ResolutionType) -> Int? {
        
        switch rType {
            
            case .LowerBound:
            
                return lowerBound /*EXIT*/
            
            case .LowerBoundNonZero:
                
                return lowerBoundNonZero /*EXIT*/
            
            case .UpperBound:
                
                return upperBound /*EXIT*/
            
            case .UpperBoundNonZero:
                
                return upperBoundNonZero /*EXIT*/
            
            case .Random:
                
                return random() /*EXIT*/
            
            case .RandomIntersecting(let set):
                
                return randomIntersecting(set)  /*EXIT*/
            
        }
        
    }
    
}
