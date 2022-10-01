//
//  ArrayCycler.swift
//  APNUtil
//
//  Created by Aaron Nance on 9/6/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import Foundation

public enum CycleType: String {
    
    case forward
    case shuffle
    
}

/// Type that iterates over the elements of an array removing each element as it steps through.
/// Once all elements of the array have been removed the cycler is refilled and iteration recommences.
///
public struct ArrayCycler<T> {
    
    // MARK: - Properties
    /// A copy of the original `Array` used to refill the hopper when it is depleted.
    public private(set) var stored: Array<T>
    
    /// The active `Array` to be cycled through.
    public private(set) var hopper: Array<T>
    
    /// Specifies whether hopper should be shuffled each time through the cycle.
    public let cycleType: CycleType
    
    /// Returns the number of `Elements` in the original/stored `Array`.
    public var fullCount: Int { return hopper.count }
    
    /// Returns the number of `Elements` currently in the hopper.
    public var remainingCount: Int { return hopper.count }
    
    /// Removes and returns the next `Element` in the hopper.  If the hopper is empty it is
    /// refilled then the first `Element` is removed and returned.
    public var next: T? {
        
        mutating get {
            
            if hopper.count == 0 { fillHopper() }
            
            return hopper.count > 0 ? hopper.removeFirst() : nil
            
        }
        
    }
    
    
    // MARK: - Overrides
    public init(_ array: Array<T>, cycleType: CycleType) {
        
        stored          = array
        hopper          = Array<T>()
        self.cycleType  = cycleType
        
        fillHopper()
        
    }
    
    
    // MARK: - Custom Methods
    /// Method that fills a hopper iff the hopper is empty.
    mutating private func fillHopper() {
        
        if hopper.count > 0 { return /*EXIT*/ }
        
        switch cycleType {
            
            case .forward: hopper = stored
            case .shuffle: hopper = stored.shuffled()
            
        }
        
    }
    
}
