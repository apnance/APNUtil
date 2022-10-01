//
//  CGRect.swift
//  APNUtil
//
//  Created by Aaron Nance on 7/25/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import UIKit

public extension CGRect {
    
    // MARK: Initializers
    /// Initializes a `CGRect` with `CGPoint.zero`
    init(width: Double, height: Double) {
    
        self.init(origin: CGPoint.zero,
                  size: CGSize(width: width, height: height) )
        
    }
    
    /// Initializes a square `CGRect` with `width` and `height` = `sideLength`
    /// - parameter origin: defaults to `CGPoint.zero`
    /// - parameter sideLength: specifies the length of each side of the square.
    init(origin: CGPoint = CGPoint.zero, sideLength length: Double) {
        
        self.init(origin: origin,
                  size: CGSize(width: length, height: length))
        
    }
    
    /// Initializes a square `CGRect` with `width` and `height` = `sideLength`
    /// - parameter origin: defaults to `CGPoint.zero`
    /// - parameter sideLength: specifies the length of each side of the square.
    init(origin: CGPoint = CGPoint.zero, sideLength length: CGFloat) {
        
        self.init(origin: origin,
                  size: CGSize(width: length, height: length))
        
    }
    
    /// Initializes a sqare `CGRect` whose `sidelength` is the `target.minDim`
    /// - Parameters:
    ///     - squareInscribedIn: a target CGRect to inscribe this CGRect inside.
    ///     - withScale: a multiplicative scale factor (use values 0 to 1)
    ///
    /// - note: does not position the `CGRect`, that is you will need to adjust the `Origin` to center
    /// it in `target`.
    init(squareInscribedIn target: CGRect,
         withScale scale: CGFloat = 1) {
        
        let sideLength = target.minDim * scale
        
        self.init(sideLength: sideLength)
        
    }
    
    
    // MARK: Properties
    /// Returns a `CGPoint` with `x` and `y` values at center of this `CGRect`
    var center: CGPoint { CGPoint(x: self.width / 2.0, y: self.height / 2.0 ) }
    
    /// Aspect ratio of the `CGRect`'s `size`
    var aspect: Double { size.aspect }
    
    /// The dimension of maller dimension (height or width).
    var minDim: CGFloat { min(height, width) }
    
    /// Returns a `CGFloat` equal to half the height of the `CGRect`
    var halfHeight: CGFloat { return height / 2 }
    
    /// Returns a `CGFloat` equal to half the width of the `CGRect`
    var halfWidth:  CGFloat { return width  / 2 }
    
    // MARK: Methods
    /// Repositions the `CGRect` to the specified x and y coordinates.
    mutating func repositionedTo(x: Double? = nil, y: Double? = nil) {
        
        let x = x != nil ? CGFloat(x!) : self.minX
        let y = y != nil ? CGFloat(y!) : self.minY
        
        repositionedTo(x: x, y: y)
    
    }
    
    /// Repositions the `CGRect` to the specified x and y coordinates.
    mutating func repositionedTo(x: CGFloat? = nil, y: CGFloat? = nil) {
        
        let origin = CGPoint(x: x ?? self.minX,
                             y: y ?? self.minY)
        
        let size = CGSize(width: width,
                          height: height)
        
        self = CGRect(origin: origin, size: size)
        
    }
    
    /// Changes the height and width of the `CGRect`
    mutating func resizedTo(width: Double? = nil, height: Double? = nil) {
        
        let w = width   != nil ? CGFloat(width!) : nil
        let h = height  != nil ? CGFloat(height!) : nil
        
        resizedTo(width: w, height: h)
        
    }
    
    /// Changes the height and width of the `CGRect`
    mutating func resizedTo(width: CGFloat? = nil, height: CGFloat? = nil) {
        
        let w = width ?? self.width
        let h = height ?? self.height
        
        self = CGRect(origin: origin, size: CGSize(width: w, height: h))
        
    }
    
}

// MARK: - Diagnostic
public extension CGRect {
    /// Returns a full representation of the UIView's frame's components.
    /// - note: `x = minX, y = minY, w = width, h = height, a =` aspect ratio
    func fullDescription(roundedTo to: Int = 3, rightPadLength pad: Int = 7) -> String {
        
        let x = String(Double(minX).roundTo(to)).rightPadded(toLength: pad)
        let y = String(Double(minY).roundTo(to)).rightPadded(toLength: pad)
        let w = String(Double(width).roundTo(to)).rightPadded(toLength: pad)
        let h = String(Double(height).roundTo(to)).rightPadded(toLength: pad)
        let a = String(aspect.roundTo(to)).rightPadded(toLength: pad)
        
        return "x:\(x) y:\(y) w:\(w) h:\(h) a:\(a)"
        
    }
    
}
