//
//  NotificationManager.swift
//  Ms Scoreminder
//
//  Created by Aaron Nance on 4/20/22.
//

import UIKit

/// Class for controlling/scheduling user notifications.
/// - note: use `shared` singleton
public class NotificationManager {
    
    /// Singleton
    public static var shared = NotificationManager()
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    /// - Parameters:
    ///   - title: text to display in nofitication title area.
    ///   - body: text to display in notification body area.
    ///   - notificationID: a string identifier used to identify your notification in UNNotificationCenter.current().
    ///     NOTE: this ID should be unique to your app to avoid collisions in the notification center.
    ///   - hour: the hour of the day you want your notification to run(use 24 hour clock times)
    ///   - minute:  the minute of the day you want your notification to run.
    ///   - second: the second of the day you want your notification to run.
    ///   - badgeNumber: badge number to display on your app's icon(0 results in no badge).
    ///   - testMode: boolean flag toggling test mode, see comment below.
    ///
    /// - NOTE: To test presenting the notification immediately:
    /// 1. Set testMode to true
    /// 2. BE SURE TO MOVE APP TO BACKGROUND within 7s of calling this method or the notification won't show.
    public func tomorrow(withTitle title: String,
                         andBody body: String,
                         notificationID: String,
                         hour: Int,
                         minute: Int,
                         second: Int,
                         badgeNumber: Int,
                         testMode: Bool = false) {
        
        let tomorrow = Calendar.current.component(.weekday, from: Date()) + 1
        
        daily(withTitle: title,
                   andBody: body,
                   notificationID: notificationID,
                   day: tomorrow,
                   hour: hour,
                   minute: minute,
                   second: second,
                   badgeNumber: badgeNumber,
                   testMode: testMode)
        
    }
    
    /// - Parameters:
    ///   - title: text to display in nofitication title area.
    ///   - body: text to display in notification body area.
    ///   - notificationID: a string identifier used to identify your notification in UNNotificationCenter.current().
    ///     NOTE: this ID should be unique to your app to avoid collisions in the notification center.
    ///   - day: the day of the week you want your notification to run daily notifications(-1 = daily, 2 = monday, 3 = tuesday, etc)
    ///   - hour: the hour of the day you want your notification to run(use 24 hour clock times)
    ///   - minute:  the minute of the day you want your notification to run.
    ///   - second: the second of the day you want your notification to run.
    ///   - badgeNumber: badge number to display on your app's icon(0 results in no badge).
    ///   - testMode: boolean flag toggling test mode, see comment below.
    ///
    /// - NOTE: To test presenting the notification immediately:
    /// 1. Set testMode to true
    /// 2. BE SURE TO MOVE APP TO BACKGROUND within 7s of calling this method or the notification won't show.
    public func daily(withTitle title: String,
                      andBody body: String,
                      notificationID: String,
                      day: Int,
                      hour: Int,
                      minute: Int,
                      second: Int,
                      badgeNumber: Int,
                      testMode: Bool = false) {
        
        self.requestNotificationAuthorization()
        self.sendDaily(withTitle: title,
                                   andBody: body,
                                   notificationID: notificationID,
                                   day: day,
                                   hour: hour,
                                   minute: minute,
                                   second: second,
                                   badgeNumber: badgeNumber,
                                   testMode: testMode)
        
    }
    
    /// - Parameters:
    ///   - title: text to display in nofitication title area.
    ///   - body: text to display in notification body area.
    ///   - notificationID: a string identifier used to identify your notification in UNNotificationCenter.current().
    ///     NOTE: this ID should be unique to your app to avoid collisions in the notification center.
    ///   - day: the day of the week you want your notification to run daily notifications(-1 = daily, 2 = monday, 3 = tuesday, etc)
    ///   - hour: the hour of the day you want your notification to run(use 24 hour clock times)
    ///   - minute:  the minute of the day you want your notification to run.
    ///   - second: the second of the day you want your notification to run.
    ///   - badgeNumber: badge number to display on your app's icon(0 results in no badge).
    ///   - testMode: boolean flag toggling test mode, see comment below.
    ///
    /// - NOTE: To test presenting the notification immediately:
    /// 1. Set testMode to true
    /// 2. BE SURE TO MOVE APP TO BACKGROUND within 7s of calling this method or the notification won't show.
    private func sendDaily(withTitle title: String,
                                       andBody body: String,
                                       notificationID: String,
                                       day: Int,
                                       hour: Int,
                                       minute: Int,
                                       second: Int,
                                       badgeNumber: Int,
                                       testMode: Bool = false) {
        
        // Cancel Pending
        cancel(notificationID)
        
        // Schedule New
        let notificationContent = UNMutableNotificationContent()
        
        // Add Content
        notificationContent.title   = title
        notificationContent.body    = body
        
        notificationContent.badge   = NSNumber(value: badgeNumber)
        
        // TODO: Clean Up - Add support for attachments
        // Attachment?
        //if let url = Bundle.main.url(forResource: "ms_icon_0",
        //                                withExtension: "png") {
        //    if let attachment = try? UNNotificationAttachment(identifier: "ms_icon_0",
        //                                                        url: url,
        //                                                        options: nil) {
        //        notificationContent.attachments = [attachment]
        //    }
        //
        //}
        
        // Set Day/Time
        var dateComponents      = DateComponents()
        dateComponents.calendar = Calendar.current
        
        if testMode {
            
            let date                = Date()
            let calendar    	    = Calendar.current
            let delay               = 7
            
            dateComponents.hour     = calendar.component(.hour, from: date)
            dateComponents.minute   = calendar.component(.minute, from: date)
            dateComponents.second   = calendar.component(.second, from: date) + delay
            
            NSLog("""
                    
                    
                    Displaying test notification in \(delay)s.
                    Please be sure to move app to background immediately or the \
                    notifation will not show.) Minute: \(minute) - Second \(second)
                    
                    """)
            
        } else {
            
            if day != -1 { dateComponents.weekday  = day   /* Tuesday is 3*/ }
            dateComponents.hour     = hour
            dateComponents.minute   = minute
            dateComponents.second   = second
            
            NSLog("""
                    
                    
                    Notification Set For:\n\tDay: \(day) - \
                    Hour: \(hour) - Minute: \(minute) - \
                    Second \(second)
                    
                    """)
            
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)
        
        let request = UNNotificationRequest(identifier: notificationID,
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            
            if let error = error {
                
                print("Notification Error: ", error)
                
            }
            
        }
        
    }
    
    /// Requests users authorization for sending notifications.
    private func requestNotificationAuthorization() {
        
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOptions) {
            
            (success, error) in
            
            if let error = error { print("Error: ", error) }
            
        }
        
    }
    
    
    /// Cancels pending notification with id == `notificationID`
    public func cancel(_ notificationID: String) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationID])
        
    }
    
    /// Clears the badge count on your app's icon.
    public func clearBadge() {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
    }
    
}
