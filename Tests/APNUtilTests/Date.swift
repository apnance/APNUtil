//
//  Date.swift
//  APNUtilTests
//
//  Created by Aaron Nance on 11/23/21.
//  Copyright © 2021 Aaron Nance. All rights reserved.
//

import Foundation

import XCTest
import Foundation
import APNUtil

class DateTests: XCTestCase {
    
    func testDescriptionLocal() {
        
        let utc     = Date().description
        let local   = Date().descriptionLocal
        
        // Check if the current time zone is UTC
        let isUTC = TimeZone.current.secondsFromGMT() == 0
        
        if !isUTC {
            
            XCTAssert(utc != local)
            
        } else {
            
            XCTAssert(utc == local)
            
        }
        
    }
    
    func testComponentsUTC() {
        
        let date        = "11/12/23".simpleDate
        
        // Time Zone
        var expected    = 0
        var actual      = date.timeZoneComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // Year
        expected        = 2023 // Difference between Phoenix time and GMT
        actual          = date.yearComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // Month
        expected        = 11 // Difference between Phoenix time and GMT
        actual          = date.monthComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // Day
        expected        = 12 // Difference between Phoenix time and GMT
        actual          = date.dayComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // Hour
        expected        = 7 // Difference between Phoenix time and GMT
        actual          = date.hourComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // Min
        expected        = 0
        actual          = date.minComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // Sec
        expected        = 0
        actual          = date.secComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
    }
    
    func testUpdate() {
        
        var date        = "1/1/21".simpleDate
        var expected    = 7
        var actual      = date.hourComponentUTC
        
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // No Update
        date    = date.update() ?? date
        actual  = date.hourComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // Update Hour
        expected    = 5
        date        = date.update(hour: expected)!
        actual      = date.hourComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // Update Min
        expected    = 6
        date        = date.update(min:expected)!
        actual      = date.minComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // Update Sec
        expected    = 7
        date        = date.update(sec:expected)!
        actual      = date.secComponentUTC
        XCTAssert(expected == actual,
                  "Expected: \(expected) - Actual: \(actual)")
        
        // Check TimeZone is UTC
        XCTAssert(date.timeZoneComponentUTC == 0, "\(date)'s time zone component is not UTC but is off by \(date.timeZoneComponentUTC)")
        
    }
    
    func testClean() {
        
        var date = "05/24/2002".simpleDate
        var actual = date.clean
        var expected = "05-24-02 00:00:00.000"
        
        print("Original: \(date)\nCleaned: \(actual)")
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        date = "12/07/2009".simpleDate
        actual = date.clean
        expected = "12-07-09 00:00:00.000"
        
        print("Original: \(date)\nCleaned: \(actual)")
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
    }
    
    func testDaysFromTo() {
        
        let leeDay = "11-17-09".simpleDate
        let beaDay = "12-7-09".simpleDate
        let beaDayPlus2 = "12-9-09".simpleDate
        
        print()
        
        XCTAssert(leeDay.daysFrom(earlierDate: beaDay) == -20)
        XCTAssert(beaDay.daysFrom(earlierDate: leeDay) == 20)
        
        XCTAssert(beaDay.daysFrom(earlierDate: beaDayPlus2) == -2)

        XCTAssert(beaDayPlus2.daysFrom(earlierDate: beaDay) == 2)

        
        XCTAssert(beaDay.daysFrom(earlierDate: beaDay) == 0)
        XCTAssert(leeDay.daysFrom(earlierDate: leeDay) == 0)
        
    }
    
    func testConsecutives() {

        func echo(_ dates: [Date]) {
            
            print("\n---")
            dates.forEach{ print($0.simple) }
            print("---")
            
        }
        
        let dayNumFormatter = DateFormatter()
            dayNumFormatter.dateFormat = "dd"
        
        // Test return counts
        // 0
        var count = 0
        var consecutives = Date().consecutives(count)
        XCTAssert(consecutives.count == abs(count), "Expected Consecutive Date Count: \(abs(count)) - Actual: \(consecutives.count))")
        echo(consecutives)
        
        // -1
        count = -1
        consecutives = Date().consecutives(count)
        XCTAssert(consecutives.count == abs(count), "Expected Consecutive Date Count: \(abs(count)) - Actual: \(consecutives.count))")
        echo(consecutives)
        
        // -4
        count = -4
        consecutives = Date().consecutives(count)
        XCTAssert(consecutives.count == abs(count), "Expected Consecutive Date Count: \(abs(count)) - Actual: \(consecutives.count))")
        echo(consecutives)
        
        // +1
        count = +1
        consecutives = Date().consecutives(count)
        XCTAssert(consecutives.count == abs(count), "Expected Consecutive Date Count: \(abs(count)) - Actual: \(consecutives.count))")
        echo(consecutives)

        // +4
        count = +4
        consecutives = Date().consecutives(count)
        XCTAssert(consecutives.count == abs(count), "Expected Consecutive Date Count: \(abs(count)) - Actual: \(consecutives.count))")
        echo(consecutives)
        
    }

    
    func testDaysFrom() {
        
        let d1 = "05.24.73".simpleDate
        let d2 = "05.17.73".simpleDate
        XCTAssert(d1.daysFrom(earlierDate: d2 ) == 7)
        XCTAssert(d2.daysFrom(earlierDate: d1 ) == -7)
        
        XCTAssert("06.22.22".simpleDate.daysFrom(earlierDate: "06.21.22".simpleDate) == 1)
        XCTAssert(Date().daysFrom(earlierDate: Date.now) == 0)
        
        let lastWeek = Date.now.weekEnding()
        XCTAssert(lastWeek.first!.daysFrom(earlierDate: Date.now) == -6)
        XCTAssert(lastWeek.last!.daysFrom(earlierDate: Date.now) == 0)
        
        let thisWeek = Date.now.weekStarting()
        XCTAssert(thisWeek.first!.daysFrom(earlierDate: Date.now) == 0)
        XCTAssert(thisWeek.last!.daysFrom(earlierDate: Date.now) == 6, "\(thisWeek.last!.daysFrom(earlierDate: Date.now))")
        
    }
    
    /// Checks that d1 and d2 are the same calendar day ignoring time element of `Date` arguments.
    func sameDay(_ d1: Date, _ d2: Date) -> Bool { d1.simple == d2.simple }
    
    func testOffsetBy() {
        
        let yesterday   = Date.yesterday
        let today       = Date.today
        let tomorrow    = Date.tomorrow
        
        // Check 365 Days In Future
        let day1        = "5-24-73".simpleDate
        let day2        = day1.offsetBy(365)!
        
        var expected    = "05-24-74"
        var actual      = day2.simple
        check(expected, actual)
        
        // Check 365 Days Ago
        expected = Calendar.current.date(byAdding: .day,
                                         value: -365,
                                         to: Date())!.simple
        actual = Date().offsetBy(-365)!.simple
        
        check(expected, actual)
        
        XCTAssert(sameDay(today.offsetBy(-1)!, yesterday))
        XCTAssert(sameDay(today.offsetBy(+1)!, tomorrow))
        
    }
    
    func testYesterday() {
        
        let yesterday   = Date.yesterday
        let today       = Date.today
        let tomorrow    = Date.tomorrow
        
        print("""
            Yesterday: \(yesterday.simple)
                Today: \(today.simple)
             Tomorrow: \(tomorrow.simple)
            """)
        
        XCTAssert(yesterday.isPast)
        XCTAssertFalse(sameDay(yesterday, today))
        XCTAssertFalse(sameDay(yesterday, tomorrow))
        XCTAssert(sameDay(yesterday.next, today))
        
    }
    
    func testToday() {
        
        let yesterday   = Date.yesterday
        let today       = Date.today
        let tomorrow    = Date.tomorrow
        
        print("""
            Yesterday: \(yesterday.simple)
                Today: \(today.simple)
             Tomorrow: \(tomorrow.simple)
            """)
        
        XCTAssert(today.isToday)
        XCTAssertFalse(today.isPast)
        XCTAssertFalse(today.isFuture)
        
        XCTAssert(sameDay(Date(), today))
        XCTAssertFalse(sameDay(today, yesterday))
        XCTAssertFalse(sameDay(today, tomorrow))
        
        XCTAssert(sameDay(today, yesterday.next))
        XCTAssert(sameDay(today, tomorrow.previous))
        
    }
    
    func testTomorrow() {
        
        let yesterday   = Date.yesterday
        let today       = Date.today
        let tomorrow    = Date.tomorrow
        
        print("""
            Yesterday: \(yesterday.simple)
                Today: \(today.simple)
             Tomorrow: \(tomorrow.simple)
            """)
        
        XCTAssert(tomorrow.isFuture)
        XCTAssertFalse(tomorrow.isToday)
        XCTAssertFalse(tomorrow.isPast)
        
        XCTAssertFalse(sameDay(Date(), tomorrow))
        XCTAssertFalse(sameDay(tomorrow, yesterday))
        XCTAssertFalse(sameDay(today, tomorrow))
        
        XCTAssert(sameDay(tomorrow, today.next))
        XCTAssert(sameDay(tomorrow.previous, today))
        
    }
    
    func testIsToday() {
        
        XCTAssert(Date.now.isToday)
        XCTAssert(Date().isToday)
        XCTAssertFalse("05.24.73".simpleDate.isToday)
        XCTAssertFalse("05.24.69".simpleDate.isToday)
        
        let thisWeek = Date.now.weekStarting()
        for day in thisWeek {
            
            if day == thisWeek.first {
                
                print("Today: \(day.simple)")
                XCTAssert(day.isToday)
                
            } else {
                
                print("Future: \(day.simple)")
                
                XCTAssertFalse(day.isToday)
                XCTAssert(day.isFuture, "\(day.simple) is future date but returns false for isFuture.")
                
            }
            
        }
        
    }
    
    func testIsPast() {
        
        XCTAssert("05.24.73".simpleDate.isPast)
        
        let lastWeek = Date.now.weekEnding()
        
        for day in lastWeek {
            
            if day == lastWeek.last {
                
                print("Today: \(day.simple)")
                
                XCTAssert(day.isToday)
                
            } else {
                
                print("Past: \(day.simple)")
                XCTAssert(day.isPast, "\(day.simple) is past date but returns false for isPast.")
                
            }
            
        }
        
    }
    
    func testIsFuture() {
        
        XCTAssert("05.24.45".simpleDate.isFuture)
        
        let thisWeek = Date.now.weekStarting()
        
        for day in thisWeek {
                        
            print("Day: \(day.simple)")

            if day == thisWeek.first {
                
                print("Today: \(day.simple)")
                XCTAssert(day.isToday)
                
            } else {
                
                print("Future: \(day.simple)")
                XCTAssert(day.isFuture, "\(day.simple) is future date but returns false for isFuture.")
                
            }
            
        }
        
        let today = Date.now
        
        XCTAssert(today.isToday, "Date.now.isToday returning false, should return true")
        
        
    }
    
    func testWeekEnding() {
        
        // weekEnding
        let birthday = "5/24/73".simpleDate
        let beforeBirthday  = birthday.weekEnding()
        
        var actual      = beforeBirthday.last!.dayOfWeek
        var expected    = "Thursday"
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        expected = "05-24-73"
        actual = beforeBirthday.last!.simple
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        actual      = beforeBirthday.first!.dayOfWeek
        expected    = "Friday"
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        expected = "05-18-73"
        actual = beforeBirthday.first!.simple
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
    }
    
    func testWeekStarting() {
        
        // weekStarting
        let birthday = "5/24/73".simpleDate
        let afterBirthday   = birthday.weekStarting()

        var actual      = afterBirthday.last!.dayOfWeek
        var expected    = "Wednesday"
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        expected        = "05-30-73"
        actual          = afterBirthday.last!.simple
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
        actual          = afterBirthday.first!.dayOfWeek
        expected        = "Thursday"
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        expected        = "05-24-73"
        actual          = afterBirthday.first!.simple
        XCTAssert(actual == expected, "Expected: \(expected) - Actual: \(actual)")
        
    }
    
    func testShiftedBy() {
        
        var first       = "05-24-73".simpleDate
        var actual      = first.shiftedBy(-2).simple
        var expected    = "05-22-73"
        XCTAssert(actual == expected, "Actual: \(actual) != Expected: \(expected)")
        
        actual          = first.shiftedBy(+2).simple
        expected        = "05-26-73"
        XCTAssert(actual == expected, "Actual: \(actual) != Expected: \(expected)")
        
        first           = "01-01-23".simpleDate
        actual          = first.shiftedBy(-365).simple
        expected        = "01-01-22"
        XCTAssert(actual == expected, "Actual: \(actual) != Expected: \(expected)")
        
        first           = "01-01-22".simpleDate
        actual          = first.shiftedBy(+365).simple
        expected        = "01-01-23"
        XCTAssert(actual == expected, "Actual: \(actual) != Expected: \(expected)")
        
    }
    
}
