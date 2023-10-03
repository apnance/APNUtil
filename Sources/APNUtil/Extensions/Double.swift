//
//  Double.swift
//  APNUtil
//
//  Created by Aaron Nance on 5/14/17.
//  Copyright © 2017 Nance. All rights reserved.
//

import Foundation

public extension Double {

    /// Converts `self` to Int equivalent.
    var int: Int { Int(self) }
    
    /// Used to compare `self` against other for equality allowing for floating point imprecision via the eFactor.
    func approxEquals(_ other: Double,
                      withErrorFactor eFactor: Double = 3.0) -> Bool {
        
        abs(self - other) < (eFactor * Double.ulpOfOne)
        
    }
    
    static var random:Double { return Double(arc4random()) / 0xFFFFFFFF }
    
    // Returns random double bewtween min and max, inclusive
    static func random(min: Double,
                       max: Double) -> Double { Double.random * (max - min) + min }
    
    // Returns random number between +/- maxAbsoluteValue
    static func randomNumber(maxAbsoluteValue: Double) -> Double {
        
        var max = maxAbsoluteValue
        max = Swift.abs(max)
        
        return random(min: -max, max: max)
    }
    
    /// Returns a `Bool` indicating whether self is convertible to `Int`
    func noIntEquivalent() -> Bool { return self.isNaN || abs(self) > Double(Int.max) }
    
    /// Returns the Double rounded to the specified number of places.
    ///
    /// Note: no rounding is done for places values less than zero.
    func roundTo(_ places: Int) -> Double {
        
        if places < 0 { return self /*EXIT*/ }
        
        let multiplier = pow(10.0,Double(places))
        
        var value = self * multiplier
        
        value.round()
        value /= multiplier
        
        return value
        
    }
    
    /// Returns just the decimal portion of the `Double` as an `Int` to `precision` # of decimal places
    func decimal(to decimalPlaces: Int) -> Int {
        
        var dec = self - Double(Int(self))
        
        dec += pow(0.1, Double(decimalPlaces + 2))
        
        return Int(dec * pow(10, Double(decimalPlaces)))
        
        
    }
    
    
    /// Returns `CGFloat` representation of self.
    var cgFloat: CGFloat { CGFloat(self) }
    
}

// MARK: - Time
public extension Double {
    
    /// Returns a `String` representation of self in the format `99m 12s`
    func timeFormat1() -> String {
        
        if noIntEquivalent() { return "-:-" /*EXIT*/ }
        
        let asInt = Int(self)
        
        return "\(asInt / 60)m \(asInt % 60)s"
        
    }
    
    /// Returns a `String` representation of self in the format `99m 12.101s`
    func timeFormat1a() -> String {
        
        if noIntEquivalent() { return "-:-" /*EXIT*/ }
        
        let seconds = self.truncatingRemainder(dividingBy: 60).roundTo(3)
                
        return "\(Int(self) / 60)m \(seconds)s"
        
    }
    
    /// Returns a `String` representation of self in the format `99:12.345`
    func timeFormat2() -> String {
        
        if noIntEquivalent() { return "-:-" /*EXIT*/ }
        
        let minutes = Int(self) / 60
        var seconds = self.truncatingRemainder(dividingBy: 60)
        
        seconds = seconds.roundTo(3)
        
        let stringSeconds = seconds < 10 ? "0\(seconds)" : String(seconds)
        
        return "\(minutes):\(stringSeconds)" /*EXIT*/
        
    }
    
    /// Returns a `String` representation of self in format `12.345` - where the minutes are omitted.
    /// - parameter roundTo: rounding precision of millisecond component
    func timeFormat3(roundTo: Int = 3) -> String {
        
        var seconds = self.truncatingRemainder(dividingBy: 60)
        
        seconds = seconds.roundTo(roundTo)
        
        let stringSeconds = seconds < 10 ? "0\(seconds)" : String(seconds)
        
        return "\(stringSeconds)" /*EXIT*/
        
    }
    
}
