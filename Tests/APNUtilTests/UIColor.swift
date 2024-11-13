//
//  GapFinder.swift
//  
//
//  Created by Aaron Nance on 7/2/24.
//

import XCTest
import APNUtil

class UIColorTests: XCTestCase {
    
    /// `XCTAsserts` that `expected == actual` with conveniently formatted
    /// assertion failure notice.
    /// - Parameters:
    ///   - expected: `expected` value
    ///   - actual: `actual` value
    ///   - shouldTrim: 'Bool' toggling auto-trimming leading and trailing
    ///   whitespace from `actual` and `expected` values.
    func check(_ expected: String, vs actual: String, shouldTrim: Bool = true) {
        
        var (expected, actual) = (expected,actual)
        
        if shouldTrim {
            
            expected    = expected.trim()
            actual      = actual.trim()
            
        }
        
        XCTAssert(expected == actual,
                        """
                        -------
                        Expected:
                        \(expected)
                        - - - -
                        
                        Actual:
                        \(actual)
                        - - - -
                        -------
                        """)
        
    }
    
    func testHex() {
        
        var color = UIColor.red
        check("#FF0000",
              vs: color.hexValue!)
        
        color = .blue
        check("#0000FF",
              vs: color.hexValue!)
        
        color = .black
        check("#000000",
              vs: color.hexValue!)
        
        color = .white
        check("#FFFFFF",
              vs: color.hexValue!)
     
        color = .clear
        check("#000000",
              vs: color.hexValue!)
        
    }
    
    func testColorFromHex() {
        
        let red = UIColor(hex: "#FF0000")!
        XCTAssert(red == UIColor.red )
        
        let green = UIColor(hex: "#00FF00")!
        XCTAssert(green == UIColor.green )
        
        let blue = UIColor(hex: "#0000FF")!
        XCTAssert(blue == UIColor.blue )
        
        XCTAssert(UIColor(hex: UIColor.blue.hexValue!)! == UIColor.blue)
        
        // Don't Work
        // NOTE: white and black don't work b/c UIColor.black and UIColor.white have different color spaces.
        XCTAssertFalse(UIColor(hex: "#FFFFFF")! == UIColor.white)
        XCTAssertFalse(UIColor(hex: UIColor.white.hexValue!)! == UIColor.white)
        XCTAssertFalse(UIColor(hex: "#000000")! == UIColor.black)
        XCTAssertFalse(UIColor(hex: UIColor.black.hexValue!)! == UIColor.black)
        
        // Work
        XCTAssert(UIColor(hex: UIColor.white.hexValue!)!.hexValue == "#FFFFFF")
        XCTAssert(UIColor(hex: UIColor.black.hexValue!)!.hexValue == "#000000")
        
    }
    
}
