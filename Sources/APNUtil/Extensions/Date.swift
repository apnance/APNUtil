//
//  Date.swift
//  APNUtil
//
//  Created by Aaron Nance on 5/29/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import Foundation

extension Calendar {
    
    /// Returns a `Calendar` with `timeZone` set to UTC time.
    static var utc: Calendar {
        
        // Create a calendar instance with the UTC time zone
        var utcCalendar         = Calendar.current
        utcCalendar.timeZone    = TimeZone(secondsFromGMT: 0)!
        
        return utcCalendar
        
    }
    
}

// - MARK: - Adjustments and Inspection
public extension Date {
    
    /// UTC based Year value
    var yearComponentUTC:   Int { Calendar.utc.component(.year, from: self ) }
    
    /// UTC based day value
    var monthComponentUTC:   Int { Calendar.utc.component(.month, from: self ) }
    
    /// UTC based day value
    var dayComponentUTC:   Int { Calendar.utc.component(.day, from: self ) }
    
    /// UTC based hour value
    var hourComponentUTC:  Int { Calendar.utc.component(.hour, from: self ) }
    
    /// UTC based minute value
    var minComponentUTC:   Int { Calendar.utc.component(.minute, from: self ) }
    
    /// UTC based second value
    var secComponentUTC:   Int { Calendar.utc.component(.second, from: self ) }
    
    /// UTC based time zone value - non-zero numbers indicate a difference from UTC(Greenwhich Mean Time)
    var timeZoneComponentUTC:   Int { Calendar.utc.component(.timeZone, from: self ) }
    
    /// Sets time zone to UTC and updates any hour, minute, and/or second components.
    func update(hour: Int?  = nil,
                min: Int?   = nil,
                sec: Int?   = nil,
                timeZone: TimeZone? = nil) -> Date? {
        
        guard hour.isNotNil || min.isNotNil || sec.isNotNil || timeZone.isNotNil
        else { return nil /*EXIT*/ }
        
        // New UTC-Based Calendar
        let calendar = Calendar.utc
        
        // Date Components
        var components = calendar.dateComponents([.year,
                                                  .month,
                                                  .day,
                                                  .hour,
                                                  .minute,
                                                  .second,
                                                  .timeZone], from: self)
        
        // Change Hour
        if let hour = hour { components.hour = hour }
        
        // Change Min
        if let min  = min { components.minute = min }
        
        // Change Sec
        if let sec  = sec { components.second = sec }
        
        // Change TZ
        if let timeZone  = timeZone { components.timeZone = timeZone }
        
        // Return New Date
        return calendar.date(from: components)
        
    }
    
    /// Returns a new date offset by `n` days from `self`
    func offsetBy(_ n: Int) -> Date? {
        let calendar = Calendar.current
        
        return calendar.date(byAdding: .day, value: n, to: self)
        
    }
    
    /// Returns today's date as `Date`
    static var now: Date { Date() }
    
    static var yesterday: Date { Date().offsetBy(-1)! }
    
    static var today: Date { Date() }
    
    static var tomorrow: Date { Date().offsetBy(1)! }
    
    /// The day after `self`
    var next: Date { offsetBy(1)! }
    
    /// The day before `self`
    var previous: Date { offsetBy(-1)! }
    
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
    /// Returns a `String` representation of  they day portion of `self` in form `04`
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        return dateFormatter.string(from: self)
    }
    
    /// Formats `self` using specified format `String` and device's current `Locale`
    /// - Parameter using: Format `String`
    /// - Returns: String formatted version of `self` using device's
    /// `Locale`
    func format(_ using: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = using
        
        // Set the locale to the current locale
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: self)
        
    }
    
    /// Returns a string representation of the time for this device's current locale.
    /// - note: use this in lieu of the default Date().description when capturing
    /// local date/time is important.
    var descriptionLocal: String { format("yyyy-MM-dd HH:mm:ss Z") }
    
    /// Returns a `String` representation of the `Date` in the form `05-24-73`
    var simple: String { format("MM-dd-yy") }
    
    /// Returns a `String` representation of the `Date` in the form `05_24_73`
    var simpleSlash: String { format("MM/dd/yy") }
    
    /// Returns a `String` representation of the `Date` in the form `05_24_73`
    var simpleUnderScore: String { format("MM_dd_yy") }
    
    /// - Returns: a `String` representation of the `Date` in the form `05.24.73`
    var simplePeriod: String { format("MM.dd.yy") }
    
    /// Returns a `String` representation of the `Date` in the form `07-14-24 15:30:05.709`
    var clean: String { format("MM-dd-yy HH:mm:ss.SSS") }
    
    
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
    /// # Example #
    /// ```swift
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
    
    
    /// Creates a date shifted by `days` number of days from current `Date`.
    /// - Parameter days: `Int` number of days(+/-) from today.
    /// - Returns: a `Date` value shifted `days` number of days from current `Date`.
    ///
    /// # Example #
    /// ```swift
    ///     // e.g.
    ///     let tomorrow = Date().shiftedBy(+1)
    ///     let today = Date().shiftedBy(0)
    ///     let yesterday = Date().shiftedBy(-1)
    ///     let aWeekAgo = Date().shiftedBy(-7)
    /// ```
    func shiftedBy(_ days: Int) -> Date {
        
        Calendar.current.date(byAdding: .day, value: days, to: self)!
        
    }
    
}

// MARK: - Time Conversion
public extension Date {
    
    /// Utilities for converting between different time units.
    struct TimeConversions {
        
        struct Seconds {
            
            static let unit                 = "s"
            
            static let inMinute: Double     = 60
            static let inHour: Double       = inMinute * Minutes.inHour
            static let inDay: Double        = Seconds.inHour * Hours.inDay
            static let inWeek: Double       = inDay * Days.inWeek
            static let inMonth: Double      = inDay * Days.inMonth
            static let inYear: Double       = inDay * Days.inYear
            static let inLeapYear: Double   = inDay * Days.inLeapYear
            
        }
        
        struct Minutes {
            
            static let unit                 = "m"
            
            static let inHour: Double       = 60
            static let inDay: Double        = Minutes.inHour * Hours.inDay
            static let inWeek: Double       = inDay * Days.inWeek
            static let inMonth: Double      = inDay * Days.inMonth
            static let inYear: Double       = inDay * Days.inYear
            static let inLeapYear: Double   = inDay * Days.inLeapYear
            
        }
        
        struct Hours {
            
            static let unit                 = "h"
                    
            static let inDay: Double        = 24
            static let inWeek: Double       = Hours.inDay * Days.inWeek
            static let inMonth: Double      = Hours.inDay * Days.inMonth
            static let inYear: Double       = Hours.inDay * Days.inYear
            static let inLeapYear: Double   = Hours.inDay * Days.inLeapYear
            
        }
        
        struct Days {
            
            static func toSeconds(_ days: Double) -> Double { (days * Seconds.inDay) }
            static func toMinutes(_ days: Double) -> Double { (days * Minutes.inDay) }
            static func toHours(_   days: Double) -> Double { (days * Hours.inDay) }
            static func toWeeks(_   days: Double) -> Double { days / Days.inWeek }
            static func toMonths(_  days: Double) -> Double { days / Days.inMonth }
            static func toYears(_   days: Double) -> Double { days / Days.inYear }
            
            static let unit                 = "d"
            
            static let inWeek : Double      = 7.0
            static let inMonth : Double     = inYear / 12.0
            static let inYear : Double      = 365.0
            static let inLeapYear : Double  = inYear + 1.0
            
        }
        
        struct Weeks {
            
            static let unit                 = "w"
                
            static let inYear: Double       = 52.0 + (1.0 / Days.inWeek)
            
        }
        
        struct Months {
            
            static let unit                 = "m"
                
            static let inYear: Double       = 12.0
            
        }
        
        struct Years {
            
            static let unit                 = "y"
            
        }
        
    }
    
}
