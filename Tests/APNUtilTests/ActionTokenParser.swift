//
//  Double.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/24/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

class TokenParserTests: XCTestCase {
    
    func testHappy() {
        
        let toParse = "Beatrix is «happy»!"
        let actualResult    = APNUtil.ActionTokenParser.parse( toParse)
        let expectedResult  = "Beatrix is =)!"
        
        print(actualResult)
        XCTAssert(actualResult == expectedResult, "Result: \(actualResult) - Expected: \(expectedResult)")
        
    }
    
    func testRandom() {

        let toParse = "Random color is «random:red,green,blue»"

        let expectedResults = ["Random color is red","Random color is green","Random color is blue"]
        var actualResult    = ""
        
        actualResult    = APNUtil.ActionTokenParser.parse(toParse)
        print(actualResult)
        XCTAssert(expectedResults.contains(actualResult))
        
        actualResult    = APNUtil.ActionTokenParser.parse(toParse)
        print(actualResult)
        XCTAssert(expectedResults.contains(actualResult))
        
        actualResult    = APNUtil.ActionTokenParser.parse(toParse)
        print(actualResult)
        XCTAssert(expectedResults.contains(actualResult))
        
        actualResult    = APNUtil.ActionTokenParser.parse(toParse)
        print(actualResult)
        XCTAssert(expectedResults.contains(actualResult))
        
        actualResult    = APNUtil.ActionTokenParser.parse(toParse)
        print(actualResult)
        XCTAssert(expectedResults.contains(actualResult))
        
    }
    
    func testCustomTokens() {
        
        let toParse = "Random color is [random>red,green,blue]"
        
        let format = ActionTokenFormat(tokenStart: "[",
                                       tokenEnd: "]",
                                       tokenDelimiter: ">" )
        
        let expectedResults  = ["Random color is red","Random color is green","Random color is blue"]
        var actualResult    = ""
        
        actualResult    = APNUtil.ActionTokenParser.parse(toParse, format: format)
        print(actualResult)
        XCTAssert(expectedResults.contains(actualResult))
        
        actualResult    = APNUtil.ActionTokenParser.parse(toParse, format: format)
        print(actualResult)
        XCTAssert(expectedResults.contains(actualResult))
        
        actualResult    = APNUtil.ActionTokenParser.parse(toParse, format: format)
        print(actualResult)
        XCTAssert(expectedResults.contains(actualResult))
        
        actualResult    = APNUtil.ActionTokenParser.parse(toParse, format: format)
        print(actualResult)
        XCTAssert(expectedResults.contains(actualResult))
        
        actualResult    = APNUtil.ActionTokenParser.parse(toParse, format: format)
        print(actualResult)
        XCTAssert(expectedResults.contains(actualResult))
        
    }
    
    func testCustomActions() {
        
        let toParse = "Ho«repeat2x:Ho», Merry Christmas!"
        let actions: ActionDictionary = [ "repeat2x" : { " \($0) \($0)" } ]
        
        let expectedResult  = "Ho Ho Ho, Merry Christmas!"
        let actualResult    = ActionTokenParser.parse(toParse,
                                                      actions: actions)
        
        print(actualResult)
        XCTAssert(actualResult == expectedResult, "Result: \(actualResult) - Expected: \(expectedResult)")
        
    }
    
}
