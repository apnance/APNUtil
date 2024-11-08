//
//  GapFinder.swift
//  
//
//  Created by Aaron Nance on 7/2/24.
//

import XCTest
import APNUtil

final class UIColorTests: XCTestCase {

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
    
}
