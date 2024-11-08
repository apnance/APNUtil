//
//  UIColor.swift
//  APNUtil
//
//  Created by Aaron Nance on 1/21/16.
//  Copyright © 2016 Nance. All rights reserved.
//

import UIKit

public extension UIColor {
    
    @objc class var gold: UIColor {
        
        UIColor(red: 1.000, green: 0.856, blue: 0.000, alpha: 1.00)
        
    }
    
    @objc class var goldOrange: UIColor {
        
        UIColor(red: 1.000, green: 0.675, blue: 0.067, alpha: 1.00)
        
    }
    
    @objc class var goldOrangeDark: UIColor {
        
        UIColor(red: 1.000, green: 0.523, blue: 0.001, alpha: 1.00)
    }
    
    @objc class var pink: UIColor {
        
        UIColor(red: 0.987, green: 0.347, blue: 1.0, alpha: 1.0)
        
    }
    
    @objc class var lightPink: UIColor {
        
        UIColor(red: 0.987, green: 0.585, blue: 1.000, alpha: 1.00)
        
    }
    
    @objc class var darkPink: UIColor {
        
        UIColor(red: 0.955, green: 0.257, blue: 1.000, alpha: 1.00)
        
    }

    /// Returns the `UIColor` with its alpha value set to 0.9
    var pointNineAlpha: UIColor { withAlphaComponent(0.9) }
    
    /// Returns the `UIColor` with its alpha value set to 0.8
    var pointEightAlpha: UIColor { withAlphaComponent(0.8) }
    
    /// Returns the `UIColor` with its alpha value set to 0.75
    var threeQuarterAlpha: UIColor { withAlphaComponent(0.75) }
    
    /// Returns the `UIColor` with its alpha value set to 0.7
    var pointSevenAlpha: UIColor { withAlphaComponent(0.7) }
    
    /// Returns the `UIColor` with its alpha value set to 0.6
    var pointSixAlpha: UIColor { withAlphaComponent(0.6) }

    /// Returns the `UIColor` with its alpha value set to 0.5
    var halfAlpha: UIColor { withAlphaComponent(0.5) }
    
    /// Returns the `UIColor` with its alpha value set to 0.4
    var pointFourAlpha: UIColor { withAlphaComponent(0.4) }
    
    /// Returns the `UIColor` with its alpha value set to 0.3
    var pointThreeAlpha: UIColor { withAlphaComponent(0.3) }
    
    /// Returns the `UIColor` with its alpha value set to 0.2
    var pointTwoAlpha: UIColor { withAlphaComponent(0.2) }
    
    /// Returns the `UIColor` with its alpha value set to 0.1
    var pointOneAlpha: UIColor { withAlphaComponent(0.1) }
    
    /// Returns the `UIColor` with its alpha value set to 0.1
    var tenthAlpha: UIColor { Utils.log("tenthAlpha has been deprecated, use pointOneAlpha instead."); return pointOneAlpha }
    
    /// Returns a darker(incr < 0) or lighter( incr > 0) version of the UIColor.
    ///
    /// Notes:
    /// 1. Increment values should fall between -1.0 and 1.0.  Increment values outside this range result in black or white.
    /// 2. The alpha value is not incremented.
    func shadeBy(_ increment: CGFloat) -> UIColor {

        incr(increment, increment, increment, nil)
        
    }
    
    /// Returns a version of this color each color componenent incremented by the corresponding increment value.
    /// NOTE: default increments are` nil` resulting in no change.
    func incr(_ rIncr: CGFloat? = nil,
              _ gIncr: CGFloat? = nil,
              _ bIncr: CGFloat? = nil,
              _ aIncr: CGFloat? = nil) -> UIColor {
        
        var (r,g,b,a) = (CGFloat(0),CGFloat(0),CGFloat(0),CGFloat(0))
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if let rIncr = rIncr { r = min(max(r + rIncr, 0.0), 1.0) }
        if let gIncr = gIncr { g = min(max(g + gIncr, 0.0), 1.0) }
        if let bIncr = bIncr { b = min(max(b + bIncr, 0.0), 1.0) }
        if let aIncr = aIncr { a = min(max(a + aIncr, 0.0), 1.0) }
        
        return UIColor(red: r, green: g, blue: b, alpha: a)

        
    }
    
}

public extension UIColor {

    @objc var purity: CGFloat { return calculatePurity() }
    @objc var redness: CGFloat { return calculateRedness() }
    @objc var greenness: CGFloat { return calculateGreenness() }
    @objc var blueness: CGFloat { return calculateBlueness() }
    
    @objc var isNotGray: Bool { return rgba.isNotGray }
    @objc var isNotBlack: Bool { return rgba.isNotBlack}
    
    var hexValue: String? { getHex() }
    var rgba: RGBA { return getRGBA() }
    
    // MARK: Initializers
    convenience init(rgba: RGBA) {
        
        self.init(red:   rgba.r,
                  green: rgba.g,
                  blue:  rgba.b,
                  alpha: rgba.a)
        
    }
    
    
    // MARK: Custom User Methods
    // Find the primary/secondary color this color is closest to and score the
    /// difference. Lower values indicate the color is closer to one of the
    /// primary or  to a "pure" primary or secondary color
    private func calculatePurity() -> CGFloat {
        
        let color = rgba
        var purity: CGFloat
        
        purity = (RGBA.RedColor - color).sumAbs()
        purity = min(purity, (RGBA.OrangeColor  - color).sumAbs())
        purity = min(purity, (RGBA.YellowColor  - color).sumAbs())
        purity = min(purity, (RGBA.GreenColor   - color).sumAbs())
        purity = min(purity, (RGBA.BlueColor    - color).sumAbs())
        purity = min(purity, (RGBA.PurpleColor  - color).sumAbs())
        
        return purity
        
    }
    
    /// Bigger numbers indicate greater redness
    private func calculateRedness() -> CGFloat {
        
        let rgb = rgba
        
        return ((rgb.r - rgb.g) + (rgb.r - rgb.b) )
        
    }
    
    /// Bigger numbers indicate greater greenness
    private func calculateGreenness() -> CGFloat {

        let rgb = rgba
        
        return ((rgb.g - rgb.r) + (rgb.g - rgb.b) )
        
    }
    
    /// Bigger numbers indicate greater blueness
    private func calculateBlueness() -> CGFloat {
        
        let rgb = rgba
        
        return ((rgb.b - rgb.r) + (rgb.b - rgb.g))
        
    }
    
    // Add Tint Value
    @objc func tint(r: CGFloat,
                    g: CGFloat,
                    b: CGFloat,
                    a: CGFloat) -> UIColor {
        
        let rgba = self.rgba
        
        rgba.r = max(0, min(rgba.r + r, 1.0))
        rgba.g = max(0, min(rgba.g + g, 1.0))
        rgba.b = max(0, min(rgba.b + b, 1.0))
        rgba.a = max(0, min(rgba.a + a, 1.0))
        
        return UIColor(rgba: rgba)
        
    }
    
    // Swap Red & Blue - for changing btw BGR <-> RGB color spaces
    @objc func swapRB() -> UIColor {
        
        let rgba = self.rgba
        
        return UIColor(rgba: RGBA(r: rgba.b, g: rgba.g, b: rgba.r, a: rgba.a))
        
    }
    
    // Split Color Into RGBA Components
    func getRGBA() -> RGBA {
        
        let rgba = RGBA()
        let _ = getRed(&rgba.r, green: &rgba.g, blue: &rgba.b, alpha: &rgba.a)
        
        return rgba
    }
    
    func getHex() -> String? {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Extract color components
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Convert to 0-255 scale and format as hex string
        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        
        return String(format: "#%02X%02X%02X", r, g, b)
        
    }
    
    func changeComponents(red: CGFloat? = nil,
                          green: CGFloat? = nil,
                          blue: CGFloat? = nil,
                          alpha: CGFloat? = nil) -> UIColor {
        
        let rgba = getRGBA()
        
        if let r = red,     r >= 0.0 && r <= 1.0 { rgba.r = r }
        if let g = green,   g >= 0.0 && g <= 1.0 { rgba.g = g }
        if let b = blue,    b >= 0.0 && b <= 1.0 { rgba.b = b }
        if let a = alpha,   a >= 0.0 && a <= 1.0 { rgba.a = a }
        
        return UIColor(rgba: rgba)
        
    }
    
}


// MARK: - RGBA Class
public class RGBA: Equatable, CustomStringConvertible {

    // MARK: Properties
    static let BlackColor    = RGBA(r: 0.0, g: 0.0, b: 0.0, a: 1.0)
    static let RedColor      = RGBA(r: 1.0, g: 0.0, b: 0.0, a: 1.0)
    static let OrangeColor   = RGBA(r: 1.0, g: 0.5, b: 0.0, a: 1.0)
    static let YellowColor   = RGBA(r: 1.0, g: 1.0, b: 0.0, a: 1.0)
    static let GreenColor    = RGBA(r: 0.0, g: 1.0, b: 0.0, a: 1.0)
    static let BlueColor     = RGBA(r: 0.0, g: 0.0, b: 1.0, a: 1.0)
    static let PurpleColor   = RGBA(r: 0.5, g: 0.0, b: 0.5, a: 1.0)
    
    public var r, g, b, a: CGFloat
    public var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) { (r,g,b,a) }
    public var description : String { return "r:\(r) \t g:\(g) \t b:\(b) \t a:\(a)" }
    var color : UIColor { UIColor(rgba: self) }
    var isNotGray : Bool { !(r == g && g == b) }
    var isNotBlack : Bool { !(r == 0 && g == 0 && b == 0) }
    
    
    // MARK: Overrides
    convenience init() { self.init(r: 0, g: 0, b: 0, a: 0) }
    
    init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        
    }
    
    
    // MARK: - Methods
    /// Sum Abs Values of Color Components
    func sumAbs(ignoreAlpha: Bool=true) -> CGFloat {

        var sum = abs(r) + abs(g) + abs(b)
        if !ignoreAlpha { sum += abs(a)}
        
        return sum
        
    }
}


// MARK: RGBA Operator Overloads
// Equality
public func == (lhs: RGBA, rhs: RGBA) -> Bool { return ( lhs.r == rhs.r && lhs.g == rhs.g && lhs.b == rhs.b && lhs.a == rhs.a) }

// Arithmetic
//  *
public func * (lhs: RGBA, rhs: CGFloat) -> RGBA { return RGBA(r: (lhs.r * rhs) , g: (lhs.g * rhs), b: (lhs.b * rhs), a: (lhs.a * rhs)) }
public func * (lhs: RGBA, rhs: RGBA) -> RGBA { return RGBA(r: (lhs.r * rhs.r) , g: (lhs.g * rhs.g), b: (lhs.b * rhs.b), a: (lhs.a * rhs.a)) }
public func *= ( lhs: inout RGBA, rhs: CGFloat) { lhs = lhs * rhs }
public func *= ( lhs: inout RGBA, rhs: RGBA) { lhs = lhs * rhs }
//  /
public func / (lhs: RGBA, rhs: CGFloat) -> RGBA { return RGBA(r: (lhs.r / rhs) , g: (lhs.g / rhs), b: (lhs.b / rhs), a: (lhs.a / rhs)) }
public func / (lhs: RGBA, rhs: RGBA) -> RGBA { return RGBA(r: (lhs.r / rhs.r) , g: (lhs.g / rhs.g), b: (lhs.b / rhs.b), a: (lhs.a / rhs.a)) }
public func /= ( lhs: inout RGBA, rhs: CGFloat) { lhs = lhs / rhs }
public func /= ( lhs: inout RGBA, rhs: RGBA) { lhs = lhs / rhs }
//  +
public func + (lhs: RGBA, rhs: CGFloat) -> RGBA { return RGBA(r: (lhs.r + rhs) , g: (lhs.g + rhs), b: (lhs.b + rhs), a: (lhs.a + rhs)) }
public func + (lhs: RGBA, rhs: RGBA) -> RGBA { return RGBA(r: (lhs.r + rhs.r) , g: (lhs.g + rhs.g), b: (lhs.b + rhs.b), a: (lhs.a + rhs.a)) }
public func += ( lhs: inout RGBA, rhs: CGFloat) { lhs = lhs + rhs }
public func += ( lhs: inout RGBA, rhs: RGBA) { lhs = lhs + rhs }
//  -
public func - (lhs: RGBA, rhs: CGFloat) -> RGBA { return RGBA(r: (lhs.r - rhs) , g: (lhs.g - rhs), b: (lhs.b - rhs), a: (lhs.a - rhs)) }
public func - (lhs: RGBA, rhs: RGBA) -> RGBA { return RGBA(r: (lhs.r - rhs.r) , g: (lhs.g - rhs.g), b: (lhs.b - rhs.b), a: (lhs.a - rhs.a)) }
public func -= ( lhs: inout RGBA, rhs: CGFloat) { lhs = lhs - rhs }
public func -= ( lhs: inout RGBA, rhs: RGBA) { lhs = lhs - rhs }
