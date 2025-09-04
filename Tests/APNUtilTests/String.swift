//
//  String.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 9/28/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import XCTest
import APNUtil

@available(iOS 16.0, *)
class StringTests: XCTestCase {
    
    func testElementNum() {
        
        let emptyArray: [String] = []
        
        XCTAssert(emptyArray.elementNum(Int.min) == "")
        XCTAssert(emptyArray.elementNum(-1) == "")
        XCTAssert(emptyArray.elementNum(0) == "")
        XCTAssert(emptyArray.elementNum(1) == "")
        XCTAssert(emptyArray.elementNum(Int.max) == "")
        
        var threeElementArray: [String] = []
        XCTAssert(threeElementArray.elementNum(Int.min) == "")
        XCTAssert(threeElementArray.elementNum(-1) == "")
        XCTAssert(threeElementArray.elementNum(0) == "")
        XCTAssert(threeElementArray.elementNum(1) == "")
        XCTAssert(threeElementArray.elementNum(Int.max) == "")
        
       threeElementArray = ["Zero", "On3", "2"]
        
        XCTAssert(threeElementArray.elementNum(Int.min) == "")
        XCTAssert(threeElementArray.elementNum(-1) == "")
        XCTAssert(threeElementArray.elementNum(0) == "Zero")
        XCTAssert(threeElementArray.elementNum(1) == "On3")
        XCTAssert(threeElementArray.elementNum(2) == "2")
        XCTAssert(threeElementArray.elementNum(3) == "")
        XCTAssert(threeElementArray.elementNum(Int.max) == "")
        
        threeElementArray = []
        XCTAssert(threeElementArray.elementNum(Int.min) == "")
        XCTAssert(threeElementArray.elementNum(-1) == "")
        XCTAssert(threeElementArray.elementNum(0) == "")
        XCTAssert(threeElementArray.elementNum(1) == "")
        XCTAssert(threeElementArray.elementNum(Int.max) == "")
        
    }
    
    func testSnip() {
        
        var text = ""
        var n = 0
        var snipped = text.snip(n)
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        XCTAssert(snipped == "")
        
        n = 1000
        snipped = text.snip(n)
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        XCTAssert(snipped == "")
        
        text = "123456"
        n = 1
        snipped = text.snip()
        XCTAssert(snipped == "12345")
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        
        n = 2
        snipped = text.snip(2)
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        XCTAssert(snipped == "1234")
        
        n = text.count
        snipped = text.snip(n)
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        XCTAssert(snipped == "")
        
        n = text.count + 10
        snipped = text.snip(n)
        print("\"\(text)\".snip(\(n))\t->\t\"\(snipped)\"")
        XCTAssert(snipped == "")
        
    }
    
    func testShuck() {
        
        var text = ""
        var n = 0
        var shucked = text.shuck(n)
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        XCTAssert(shucked == "")
        
        n = 1000
        shucked = text.shuck(n)
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        XCTAssert(shucked == "")
        
        text = "[ABCBA]"
        
        shucked = text.shuck()
        XCTAssert(shucked == "ABCBA")
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        
        n = 2
        shucked = text.shuck(n)
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        XCTAssert(shucked == "BCB", "shucked should == \"\" but equals \(shucked)")
        
        n = text.count
        shucked = text.shuck(n)
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        XCTAssert(shucked == "")
        
        n = text.count + 10
        shucked = text.shuck(n)
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        XCTAssert(shucked == "")
        
        text = "BEA"
        n = 1
        shucked = text.shuck(n)
        XCTAssert(shucked == "E")
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        
        
        text = "BEA"
        n = 2
        shucked = text.shuck(n)
        XCTAssert(shucked == "")
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        
        text = "BEA"
        n = 10
        shucked = text.shuck(n)
        XCTAssert(shucked == "")
        print("\"\(text)\".shuck(\(n))\t->\t\"\(shucked)\"")
        
        XCTAssert("HuskCornHusk".shuck(4) == "Corn", "\("HuskCornfHusk".shuck(4))")
        
        XCTAssert("[shuck me]".shuck() == "shuck me", "\("[shuck me]".shuck())")
        
    }
    
    func testTidy() {
        
        var text = "    Tidy Me!    "
        var actual = text.tidy()
        var expected = "Tidy Me!"
        XCTAssert(actual == expected, "Expected: '\(expected)' - Actual: '\(actual)'")
        
        text = " Tidy    Me! "
        actual = text.tidy()
        expected = "Tidy Me!"
        XCTAssert(actual == expected, "Expected: '\(expected)' - Actual: '\(actual)'")
        
        text = "      Me!    "
        actual = text.tidy()
        expected = "Me!"
        XCTAssert(actual == expected, "Expected: '\(expected)' - Actual: '\(actual)'")
        
        text = "Tidy    Me!    "
        actual = text.tidy()
        expected = "Tidy Me!"
        XCTAssert(actual == expected, "Expected: '\(expected)' - Actual: '\(actual)'")
        
        text = "     Tidy Me!    "
        actual = text.tidy()
        expected = "Tidy Me!"
        XCTAssert(actual == expected, "Expected: '\(expected)' - Actual: '\(actual)'")
        
        text = "Tidy    Me!"
        actual = text.tidy()
        expected = "Tidy Me!"
        XCTAssert(actual == expected, "Expected: '\(expected)' - Actual: '\(actual)'")
        
    }
    
    func testIsNotEmpty() {
        
        XCTAssert(!"".isNotEmpty)
        XCTAssertFalse("".isNotEmpty)
        
        XCTAssert("Stuff".isNotEmpty)
        XCTAssertFalse(!"Stuff".isNotEmpty)
        
    }
    
    
    func testHasAlphaPrefix() {
        
        XCTAssert("a".hasAlphaPrefix)
        XCTAssert("A".hasAlphaPrefix)
        XCTAssert("z".hasAlphaPrefix)
        XCTAssert("Z".hasAlphaPrefix)
        XCTAssert("b1231".hasAlphaPrefix)
        XCTAssert("B1231".hasAlphaPrefix)
        
        XCTAssertFalse("".hasAlphaPrefix)
        
        XCTAssertFalse("123".hasAlphaPrefix)
        XCTAssertFalse("9".hasAlphaPrefix)
        XCTAssertFalse("1234".hasAlphaPrefix)
        
        XCTAssertFalse("{".hasAlphaPrefix)
        
        XCTAssertFalse("🧐".hasAlphaPrefix)
        
    }
    
    func testHasNumericPrefix() {

        XCTAssertFalse("a".hasNumericPrefix)
        XCTAssertFalse("A".hasNumericPrefix)
        XCTAssertFalse("z".hasNumericPrefix)
        XCTAssertFalse("Z".hasNumericPrefix)
        XCTAssertFalse("b1231".hasNumericPrefix)
        XCTAssertFalse("B1231".hasNumericPrefix)
        
        XCTAssertFalse("".hasNumericPrefix)
        
        XCTAssert("123".hasNumericPrefix)
        XCTAssert("9".hasNumericPrefix)
        XCTAssert("1234".hasNumericPrefix)
        
        XCTAssertFalse("{".hasNumericPrefix)
        
        XCTAssertFalse("🧐".hasNumericPrefix)
        
    }
    
    func testProcessed() {
        
        let test1 = " BlAh BLAH"
        var working = test1
        XCTAssert(working == test1)
        
        working = working.processed({ $0.uppercased() })
        XCTAssert(working == " BLAH BLAH")
        
        working = test1
        XCTAssert(working == test1)
        
        working = working.processed({ $0.lowercased() })
        XCTAssert(working == " blah blah")
        
        working = test1
        XCTAssert(working == test1)
        
        working = working.processed( String.lowerNoSpaces )
        XCTAssert(working == "blahblah")
        
    }
    
    func testLeftPadding() {
        
        // 10
        let zonk = "Zonk"
        let zonkLeftPadded10 = zonk.leftPadded(toLength: 10, withPad: " ")
        print("|\(zonkLeftPadded10)|")
        XCTAssert(zonkLeftPadded10 == "      \(zonk)")
        
        // 3
        let zonkLeftPadded3 = zonk.leftPadded(toLength: 3, withPad: " ")
        print("|\(zonkLeftPadded3)|")
        XCTAssert(zonkLeftPadded3 == "onk")
        
        // 0
        let zonkLeftPadded0 = zonk.leftPadded(toLength: 0, withPad: " ")
        print("|\(zonkLeftPadded0)|")
        XCTAssert(zonkLeftPadded0 == "")
        
    }
    
    func testRightPadding() {
        
        // 10
        let zonk = "Zonk"
        let zonkRightPadded10 = zonk.rightPadded(toLength: 10, withPad: " ")
        print("|\(zonkRightPadded10)|")
        XCTAssert(zonkRightPadded10 == "\(zonk)      ")
        
        // 3
        let zonkRightPadded3 = zonk.rightPadded(toLength: 3, withPad: " ")
        print("|\(zonkRightPadded3)|")
        XCTAssert(zonkRightPadded3 == "Zon")
        
        // 0
        let zonkRightPadded0 = zonk.rightPadded(toLength: 0, withPad: " ")
        print("|\(zonkRightPadded0)|")
        XCTAssert(zonkRightPadded0 == "")
        
    }
    
    func testCenterPadding() {
        
        // 13
        let test = "123456789"
        var len = 13
        let testCenterPadded13 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(testCenterPadded13)|")
        XCTAssert(testCenterPadded13 == "  \(test)  ")
        
        // 12
        len = 12
        let testCenterPadded12 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(testCenterPadded12)|")
        XCTAssert(testCenterPadded12 == "  \(test) ")
        
        
        // 10
        len = 10
        let testCenterPadded10 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(testCenterPadded10)|")
        XCTAssert(testCenterPadded10 == " \(test)")
        
        // 8
        len = 8
        let testCenterPadded8 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(testCenterPadded8)|")
        XCTAssert(testCenterPadded8 == "12345678")
        
        // 7
        len = 7
        let testCenterPadded7 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(testCenterPadded7)|")
        XCTAssert(testCenterPadded7 == "2345678")
        
        // 1
        len = 1
        let zonkCenterPadded1 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(zonkCenterPadded1)|")
        XCTAssert(zonkCenterPadded1 == "5")
        
        // 0
        len = 0
        let zonkCenterPadded0 = test.centerPadded(toLength: len, withPad: " ")
        print("\(len)|\(zonkCenterPadded0)|")
        XCTAssert(zonkCenterPadded0 == "")
        
    }
    
    func testBase26StringToInt() {
        
        var expected    = 0
        var actual      = "A".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        expected        = 1
        actual          = "B".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        expected        = 25
        actual          = "Z".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        expected        = 26
        actual          = "AA".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        expected        = 52
        actual          = "BA".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        expected        = 702
        actual          = "AAA".base26StringToInt ?? -1279
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        XCTAssertNil("AB1".base26StringToInt)
        XCTAssertNil("1AB".base26StringToInt)
        XCTAssertNil("A123".base26StringToInt)
        
        // Casing
        XCTAssert("A".base26StringToInt == "a".base26StringToInt)
        XCTAssert("B".base26StringToInt == "b".base26StringToInt)
        XCTAssert("AAA".base26StringToInt == "aaa".base26StringToInt)
        
        // Upper
        for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            
            let str = String(char)
            XCTAssertNotNil(str.base26StringToInt,
                            "\"\(str)\".base26StringToInt returned nil value")
            
        }
        
        // Lower
        for char in "abcdefghijklmnopqrstuvwxyz" {
            
            let str = String(char)
            XCTAssertNotNil(str.base26StringToInt,
                            "\"\(str)\".base26StringToInt returned nil value")
            
        }
        
        // Nils
        for char in "123456789!@#$%^&*() _+:'[]\\/" {
            
            let str = String(char)
            XCTAssertNil(str.base26StringToInt,
                         "\"\(str)\".base26StringToInt returned non-nil value")
            
        }
        
    }
    
    func testIsSingleDigit() {
        
        var singles     = [0,1,2,3,4,5,6,7,8,9]
        var notSingles  = [10,11,22,33,44,55,66,77,88,99, 1000, 1002, 99999]
        var strings     = ["a", "A", "z", "Z", "q", "Q", "!", "!@#!$%%!#%", "^$@&"]
        
        for single in singles {
            
            XCTAssert(single.description.isSingleDigit)
            
        }
        
        for not in notSingles {
            
            XCTAssertFalse(not.description.isSingleDigit)
            
        }
        
        for not in strings {
            
            XCTAssertFalse(not.description.isSingleDigit)
            
        }
        
        for not in ".<>_\"'!@#$%^&*() _+:'[]\\/" {
            
            XCTAssertFalse(not.description.isSingleDigit)
            
        }
        
    }
    
    func testObfuscate() {
        
        let iterations  = 1000
        let originals   = ["ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789- ._~:/?#[]@!$&'()*+,;=%",
                           """
                            https://stackoverflow.com/questions/1547899/which-characters\
                            -make-a-url-invalid#:~:text=In%20general%20URIs%20as%20defined\
                            %20by%20RFC%203986,where%20in%20the%20URI%20these%20characters\
                            %20may%20occur.
                            """]
        
        for original in originals {
            
            // Test Shift
            for shiftBy in 0...45 {
            
                let shifted     = original.shift(by: shiftBy)
                let unshifted   = shifted.shift(by: -shiftBy)
                
                if shiftBy != 0 { XCTAssert(shifted != original) }
                
                XCTAssert(unshifted == original)
                
            }
            
            print("\n-----------------------------")
            
            for i in 1...iterations {
                
                let obfuscated   = original.obfuscated
                let unobfuscated = obfuscated.unobfuscated
                
                XCTAssert(obfuscated != unobfuscated,
                          "OBFUSCATED:\(obfuscated)\nequals\nORIGINAL:\(unobfuscated)\n but should not!")
                
                XCTAssert(unobfuscated == original,
                          "OBFUSCATED:\(obfuscated)\ndoes not equal\nORIGINAL:\(original)\n but should!")
                
                print("#\(i)\nORIGINAL:\t\t\(original)\nOBFUSCATED:\t\t\(obfuscated)\nUNOBFUSCATED:\t\(unobfuscated)\n")
                
            }
            
            print("\n-----------------------------\n")
            
        }
    }
    
    
    func testTimeZoneOffset() {
        
        // Create UTC Date
        let dateUTC = "2024-12-09 22:40:35 +0000".fullDate
        let datePHX = "2024-12-09 22:40:35 -0700".fullDate
        
        let dateUTC2 = Date().description
        
        
        let offsetDateUTC   = dateUTC.description.timeZoneOffset
        let offsetDateUTC2  = dateUTC2.description.timeZoneOffset
        let offsetDatePHX   = datePHX.descriptionLocal.timeZoneOffset
        
        
        XCTAssert(offsetDateUTC == offsetDateUTC2,  "\n\(offsetDateUTC)(UTC) == \(offsetDateUTC2)(UTC2)")
        XCTAssert(offsetDateUTC != offsetDatePHX,   "\n\(offsetDateUTC)(UTC) == \(offsetDatePHX)(PHX)")
        
    }
    
    func testSimpleDate() {
        
        let date1a = "12/1/24".simpleDate
        let date2a = "12.1.24".simpleDate
        let date3a = "12-1-24".simpleDate
        
        XCTAssert(date1a == date2a)
        XCTAssert(date3a == date2a)
        XCTAssert(date3a == date1a)
        
        let date1b = "12/01/2024".simpleDate
        let date2b = "12.1.2024".simpleDate
        let date3b = "12-1-2024".simpleDate
        
        XCTAssert(date1a == date1b)
        XCTAssert(date2a == date2b)
        XCTAssert(date3a == date3b)
        
    }
    
    func testSimpleDateMaybe() {
        
        let date1 = "12/1/24".simpleDateMaybe
        let date2 = "12.1.24".simpleDateMaybe
        let date3 = "12-1-24".simpleDateMaybe
        
        let date1a = "12/1/24".simpleDate
        let date2a = "12.1.24".simpleDate
        let date3a = "12-1-24".simpleDate
        
        let date4 = "12-1-24-24".simpleDateMaybe
        let date5 = "BLAH!!!".simpleDateMaybe
        let date6 = "".simpleDateMaybe
        
        
        XCTAssert(date1.isNotNil)
        XCTAssert(date2.isNotNil)
        XCTAssert(date3.isNotNil)
        
        XCTAssert(date1 == date1a)
        XCTAssert(date2 == date2a)
        XCTAssert(date3 == date3a)
        
        XCTAssert(date1 == date2)
        XCTAssert(date3 == date2)
        XCTAssert(date3 == date1)
        
        XCTAssert(date4.isNil)
        XCTAssert(date5.isNil)
        XCTAssert(date6.isNil)
        
        
    }
    
    func testFullDate() {
        
        func testEquality(_ date1: Date, _ date2: Date) {
            
            print("""
                    
                    Comparing: 
                    \(date1) 
                    to 
                    \(date2)
                    date1 == date2 ? \(date1 == date2)
                    
                    """)
            
            XCTAssert(date1.yearComponentUTC      == date2.yearComponentUTC)
            XCTAssert(date1.monthComponentUTC     == date2.monthComponentUTC)
            XCTAssert(date1.dayComponentUTC       == date2.dayComponentUTC)
            
            XCTAssert(date1.hourComponentUTC      == date2.hourComponentUTC)
            XCTAssert(date1.minComponentUTC       == date2.minComponentUTC)
            XCTAssert(date1.secComponentUTC       == date2.secComponentUTC)
            XCTAssert(date1.timeZoneComponentUTC  == date2.timeZoneComponentUTC)
        }
        
        let now         = Date()
        let nowString   = now.description
        let nowFullDate = nowString.fullDate
        
        testEquality(now, nowFullDate)
        
    }
    
    func testFullDateMaybe() {
        
        let dateYes = "2024-12-04 01:17:52 +0000".fullDate
        let dateMaybe = "2024-12-04 01:17:52 +0000".fullDateMaybe
        let dateNo = "Jabber".fullDateMaybe
        
        XCTAssert(dateMaybe.isNotNil)
        XCTAssert(dateNo.isNil)
        
        XCTAssert(dateYes == dateMaybe)
        
    }
    
    func testAsRegularExpression() {
        
        var strings = ["Simple", "", "123123BlahBlah12313_"]
        
        for string in strings { XCTAssert( string == string.asRegularExpression) }
        
        strings = [
            "$This is a +* * ? $entence!",
            "$This is a +**? $entence!" ]
        
        for string in strings {
            
            let regEx  = string.asRegularExpression
            XCTAssert(string != regEx)
            XCTAssert(string =~ regEx,
                    """
                    
                    -----
                    String:
                    \(string)
                    RegEx:
                    \(regEx)
                    -----
                    """)
            
            XCTAssertFalse(string =~ string)
            
            print("""
                
                -----
                String:
                \(string)
                RegEx:
                \(regEx)
                -----
                """)
            
        }
    }
    
    func testAsRegularExpression2() {
        
        let original =
        """
        c,50.16,1974-11-19 07:00:00 +0000
        c,0.05016,2019-03-21 07:00:00 +0000
        s,160.16,1974-11-19 07:00:00 +0000
        s,16.016,1975-05-26 07:00:00 +0000
        s,1.6016,2011-12-09 07:00:00 +0000
        s,0.16016,2019-03-21 07:00:00 +0000
        
        
        [Note: above output copied to pasteboard]
        """
        
        let asRegEx = original.asRegularExpression
        
        XCTAssert(original =~ asRegEx,
            """
            
            -----
            Original:
            \(original)
            RegEx:
            \(asRegEx)
            -----
            """)
        
    }
    
    func testEqualsRegExpOperator() {
        
        XCTAssert("adsfsa" =~ ".*")
        XCTAssert("\t\n " =~ "\\s+")
        XCTAssert("[]" =~ "\\[\\]")
        XCTAssert("This is a bunch of words!" =~ "^[A-Z][^.?!]*[.?!]$")
        XCTAssert("FouR" =~ "....")
        XCTAssertFalse("FIVE" =~ ".....")
        
    }
    
    func testDiff() {
        
        let string1 = """
                        Alice was beginning to get very tired of sitting by her 
                        sister on the bank, and of having nothing to do: once or
                        twice she had peeped into the book her sister was 
                        reading, but it had no pictures or conversations in it, 
                        “and what is the use of a book,” thought Alice, 
                        “without pictures or conversations?”
                        """
        
        let string2     = string1
        
        // Identical Strings
        check("", String.diff(string1, string2))
        
        let string3 = """
                        Alice was beginning to get very tired of sitting by her 
                        sister on the bank, and of having nothing to do: once or
                        twice she had peeped into the book her sister was. 
                        reading, but it had no pictures or conversations in it, 
                        “and what is the use of a book,” thought Alice, 
                        “without pictures or conversations?”
                        """
        
        // Space Replaced by Period
        check("""
                Alice was beginning to get very tired of sitting by her 
                sister on the bank, and of having nothing to do: once or
                twice she had peeped into the book her sister was[ |.]
                reading, but it had no pictures or conversations in it, 
                “and what is the use of a book,” thought Alice, 
                “without pictures or conversations?”
                """,
              String.diff(string1, string3))
        
        let string4 = "This is 'Going to be hard to find!'"
        let string5 = "This is `Going to be hard to find!'"
        
        // Different Paren
        check("This is ['|`]Going to be hard to find!'",
              String.diff(string4, string5))
        
        // RHS Longer
        check("Loooooong[|er]", String.diff("Loooooong", "Loooooonger"))
        
        // LHS Longer
        check("Loooooong[er|]", String.diff("Loooooonger", "Loooooong"))
        
    }
    
    func testDiffDeep() {
        
        func test(str1: String,
                  str2: String,
                  expectedDiffs: [Int: (Character, Character)]) {
            
            let diffs = String.diffDeep(str1, str2)
            let diffKeys = diffs.keys.sorted()
            
            let expectedDiffsKeys = expectedDiffs.keys.sorted()
            
            XCTAssert(expectedDiffsKeys == diffKeys)
            
            for key in diffKeys {
                
                let expected    = expectedDiffs[key]
                let actual      = diffs[key]
                
                XCTAssert(expected?.0       == actual?.0
                          && expected?.1    == actual?.1,
                          """
                            
                            -----
                            Char \(key)
                            - - -
                            Expected: (\(expected?.0.description ?? "nil"),\(expected?.1.description ?? "nil"))
                            Actual:   (\(actual?.0.description ?? "nil"),\(actual?.1.description ?? "nil"))
                            -----
                            """)
                
            }
            
            if expectedDiffsKeys != diffKeys {
                
                
                print("""
                
                -----
                \(str1)
                \(str2)
                - - -
                """)
                
                for key in diffs.keys.sorted() {
                    
                    let actual  = diffs[key]
                    let expected    = expectedDiffs[key]
                    
                    print("""
                            [\(key)] '\(expected?.0.description ?? "nil"),\(expected?.1.description ?? "nil")' \
                            -> \
                            '\(actual?.0.description ?? "nil"),\(actual?.1.description ?? "nil")'
                            """)
                    
                }
                
                print("-----")
                
            }
            
        }
        
        test(str1: "Aaron", str2: "AaRon", expectedDiffs: [2 : ("r", "R")])
        
        let string1 = """
                        Alice was beginning to get very tired of sitting by her 
                        sister on the bank, and of having nothing to do: once or
                        twice she had peeped into the book her sister was 
                        reading, but it had no pictures or conversations in it, 
                        “and what is the use of a book,” thought Alice, 
                        “without pictures or conversations?”
                        """
        
        let string2     = string1
        
        test(str1: string1, str2: string2, expectedDiffs: [:])
        
        let string3 = """
                        alice was beginning to get very tired of sitting by her 
                        sister on the bank, and of having nothing to do: once or
                        twice she had peeped into the  ook her sister was.
                        reading, but it had no pictures or conversations in it, 
                        “and what is the Use of a book,” thought Alice, 
                        “without pictures or conṽersations?”
                        """
        test(str1: string1, str2: string3, expectedDiffs: [0: ("A","a"),
                                                           144:("b"," "),
                                                           163:(" ","."),
                                                           239:("u","U"),
                                                           295:("v","ṽ")])
        
    }
    
}
