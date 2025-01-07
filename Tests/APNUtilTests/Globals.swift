//
//  Globals.swift
//  APNUtil
//
//  Created by Aaron Nance on 12/12/24.
//

import XCTest
import APNUtil

/// Global test func for checking string results for equivalence then finding first difference if not equal.
func check(_ expecteDiff: String, _ actualDiff: String) {
    
    XCTAssert(expecteDiff == actualDiff,
                """
                
                -----
                Expected:
                \(expecteDiff)
                - - - 
                Actual:
                \(actualDiff)
                - - -
                Diff:
                \(String.diff(expecteDiff, actualDiff))
                -----
                """)
    
}
