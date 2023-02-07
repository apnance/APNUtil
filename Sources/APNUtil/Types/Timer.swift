//
//  APNTimer.swift
//  APNUtil
//
//  Created by Aaron Nance on 2/11/16.
//  Copyright © 2016 Nance. All rights reserved.
//

import Foundation

public typealias intervalRepeatAction = (Timer) -> ()

public class APNTimer {
    
    private static var runningTimers = [String: APNTimer]()
    public let start:       NSDate
    public var end:         NSDate
    private var paused:     Bool
    public var isPaused:    Bool { paused }
    public var id:          String
    
    public var elapsed: Double {
        
        if !paused { end = NSDate() }
        
        return end.timeIntervalSince(start as Date)
        
    }
    
    public var elapsedDisplay: String { elapsed.timeFormat1() }
    
    public var timer: Timer?
    
    @discardableResult public init(name: String,
                repeatInterval: Double? = nil,
                repeatAction: intervalRepeatAction? = nil) {

        start       = NSDate()
        end         = NSDate()
        paused      = false
        id          = name

        if let repeatEvery = repeatInterval, let repeatAction = repeatAction {
            timer = Timer.scheduledTimer(withTimeInterval: repeatEvery,
                                         repeats: true,
                                         block: repeatAction)
        }
        
        // ADD timer to static list of running timers
        APNTimer.runningTimers[id] = self
        
    }
    
    public func pause() {
        
        if !paused { end = NSDate() }
        
        paused = true
        
    }
    
    public func stop() {
        
        pause()
        
        APNTimer.runningTimers.removeValue(forKey: id)
        
        timer?.invalidate()
        
    }
    
    public static func timeAndReport(timerID: String, action:() -> ()) {
        
        let timer = APNTimer(name: timerID)
    
        action()
        
        timer.stopAndPrint(prefix: "Total Elapsed Time [\(timer.id)]: ")
        
    }
    
    public func printElapsed(prefix: String?) {
        
        if prefix == nil { print(elapsed) }
        else { print("\(prefix!)\(elapsed)") }
        
    }
    
    public func stopAndPrint() { stopAndPrint(prefix: nil) }
    
    public func stopAndPrint(prefix: String?) {
        
        self.stop(); printElapsed(prefix: prefix)
        
    }
    
    /// Returns success flag, true if there was a timer with name == `named`, false otherwise
    @discardableResult public static func stopTimer(named: String) -> Bool {
        
        if let timer = runningTimers[named] {
            
            timer.stop()
            return true /*EXIT*/
            
        } else {
            
            return false
            
        }
        
    }
    
    public static func stopAllTimers() { APNTimer.runningTimers.forEach{ $1.stop() } }
    
    public static func stopAndPrintAllTimers() {
        
        APNTimer.runningTimers.forEach() { $1.pause() }
        let timers = APNTimer.runningTimers.sorted(){return $0.1.id < $1.1.id }
        timers.forEach() { $1.stopAndPrint(prefix: "[\($1.id)]\t\t") }
        
    }
    
}
