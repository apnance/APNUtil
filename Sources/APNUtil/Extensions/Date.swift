//
//  Date.swift
//  APNUtil
//
//  Created by Aaron Nance on 5/29/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import Foundation

public extension Date {
    
    /// Returns today's date as `Date`
    static var now: Date { Date() }
    
    /// Returns the number of seconds in 1 day.
    static let secondsInDay = (60.0 * 60.0 * 24.0)
    
    /// Returns a `String` representation of today's `Date`
    ///
    /// e.g. "Monday"
    static var dayOfWeek: String { Date().dayOfWeek }
    
    /// Returns a `String` representation of `self`
    ///
    /// e.g. "Monday"
    var dayOfWeek: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        
        return dateFormatter.string(from: self)
        
    }
    
    /// Returns a  `Bool` indicating if `self` is a different day in the past
    /// - note: ignores time aspecte of `Date`
    var isPast: Bool { daysFrom(earlierDate: Date.now) < 0 }
    
    /// Returns a  `Bool` indicating if `self` is the same day/month/year as `Date()`
    var isToday: Bool { simple == Date().simple }
    
    /// Returns a  `Bool` indicating if `self` is a different day in the future.
    /// - note: ignores time aspecte of `Date`
    var isFuture: Bool { daysFrom(earlierDate: Date.now) > 0 }
    
    // MARK: - Conversion to String
    /// Returns a `String` representation of the `Date` in the form `05-24-73`
    var simple: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yy"
        
        return dateFormatter.string(from: self)
        
    }
    
    /// Returns a `String` representation of  they day portion of `self` in form `04`
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        return dateFormatter.string(from: self)
    }
    
    /// Returns a `String` representation of the `Date` in the form `05_24_73`
    var simpleSlash: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        
        return dateFormatter.string(from: self)
        
    }
    
    /// Returns a `String` representation of the `Date` in the form `05_24_73`
    var simpleUnderScore: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM_dd_yy"
        
        return dateFormatter.string(from: self)
        
    }
    
    /// - Returns: a `String` representation of the `Date` in the form `05.24.73`
    var simplePeriod: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yy"
        
        return dateFormatter.string(from: self)
        
    }
    
    // MARK: - Mathematical Comparisons
    /// Returns the number of days bewteen `self` and the specified `Date`.
    ///
    /// - note: returns a negative number if `self` is earlier than argument `Date`.
    func daysFrom(earlierDate earlier: Date) -> Int {
        
        self.daysSinceRef - earlier.daysSinceRef
        
    }
    
    /// Returns the integer number of days from `self` to the system’s absolute
    /// reference `date (00:00:00 UTC on 1 January 2001` as calculated solely by the day
    /// numbers, ignoring minutes and seconds (i.e. two dates with 1 day apart but less than 24 hours
    /// apart will still return a difference of 1).
    ///
    /// - e.g. the dates 2022-12-15 11:59:59 and 2022-12-16 12:00:00 would return a difference of 1.0 despite being different by only 1 second.
    var daysSinceRef: Int { Int(self.timeIntervalSinceReferenceDate / Date.secondsInDay) }
    
    /// Returns an array containing `numDays` `Dates` either starting on(`numDays` >= 0`)
    /// or ending on(`numDays < 0`) chronologically ordered consecutive either starting or ending on `self`.
    ///
    /// See sample code below for usage details.
    ///
    /// - Parameters:
    ///     - numDays: the number of chronological `Date`s.  Negative values result in a block of Dates
    ///     ending with `self`, positive values result in a block starting with `self`
    ///
    /// ```
    /// // e.g.
    /// let today = Date()
    ///
    /// // returns a 7 element array starting with today's Date running
    /// // chronologically through to the day 6 days from today.
    /// today.consecutives(7).
    ///
    /// // returns a 7 element array starting with the Date from 6 days ago
    /// // running chronologically through to today
    /// today.consecutives(-7).
    ///
    /// // returns a single element array containing today's Date
    /// today.consecutives(1)
    ///
    /// // returns empty array.
    /// today.consecutives(0)
    /// ```
    ///  - Returns: an array of chronological `Date`s either starting or ending with the `self`
    ///
    func consecutives(_ numDays: Int) -> [Date] {
        
        let dayCount = abs(numDays)
        var week        = Array(repeating: self, count: dayCount)
        let calendar    = Calendar.current
        
        let start = numDays < 0 ? numDays + 1 : 0
        
        for i in 0..<dayCount {
            
            let next = start + i
            
            week[i] = calendar.date(byAdding: .day,
                                    value: next,
                                    to: self)!
            
        }
        
        return week
        
    }
    
    /// Returns dates for the previous week ending with `self` in chronological order.
    func weekEnding() -> [Date] { consecutives(-7) }
    
    /// Returns dates for the next week beginning with `self` in chronological order.
    func weekStarting() -> [Date] { consecutives(7) }
    
    /// Returns a copy of `self` sans time components.
    func sansTime() -> Date {
        
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))!
        
    }
    
}
