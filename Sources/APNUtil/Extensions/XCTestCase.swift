//
//  XCTestCase.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/8/24.
//

//import XCTest
//import UIKit
//
//public extension XCTestCase {
//    
//    /// `XCTAsserts` that `expected == actual` with conveniently formatted
//    /// assertion failure notice.
//    /// - Parameters:
//    ///   - expected: `expected` value
//    ///   - actual: `actual` value
//    ///   - shouldTrim: 'Bool' toggling auto-trimming leading and trailing
//    ///   whitespace from `actual` and `expected` values.
//    func check(_ expected: String, vs actual: String, shouldTrim: Bool = true) {
//        
//        var (expected, actual) = (expected,actual)
//        
//        if shouldTrim {
//            
//            expected    = expected.trim()
//            actual      = actual.trim()
//            
//        }
//        
//        XCTAssert(expected == actual,
//                    """
//                    -------
//                    Expected:
//                    \(expected)
//                    - - - -
//                    
//                    Actual:
//                    \(actual)
//                    - - - -
//                    -------
//                    """)
//        
//    }
//    
//}
