//
//  Globals.swift
//  APNUtil
//
//  Created by Aaron Nance on 6/29/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import UIKit

// - MARK: DispatchQueue
/// Runs closure on main thread after specified delay in seconds.
public func async(_ code: @escaping () -> (), after: Double) {
    
    let delay = max(after, 0.0)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) { code() }
    
}

// - MARK: Misc
/// Triggers a haptic response with default style of .light
public func haptic(withStyle style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
    
    UIImpactFeedbackGenerator(style: style).impactOccurred()
    
}

// - MARK: Printing
/// Sends the message to loud(_:) if the boolean is true.
@discardableResult public func loudIf(_ shouldPrint: Bool,
                                      msg: String) -> Bool {
    
    if shouldPrint { loud(msg) }
    
    return shouldPrint
    
}

/// Screams a message to console. Useful for printing easily spotted debugging messages.
public func loud(_ msg: String, echoTimeStamps: Bool = false) {
    
    #if DEBUG
    var timestamp = ""
    if echoTimeStamps {
        timestamp = """
                    - \(DateFormatter.localizedString(from: Date(),
                                                      dateStyle: .none,
                                                      timeStyle: .medium))
                    """
    }
    
    print("<LOUD\(timestamp)>\n\(msg)\n</LOUD\(timestamp)>\n")
    #endif
    
}

public func print(_ text: String, showThread: Bool) {
    
    assert(Thread.isMainThread)
    print("\nThread: \(Thread.current)\n\(text)\n")
    
}

/// Prints `text` to the pasteboard.
public func printToClipboard(_ text: String) {
    
    #if DEBUG
    print("[Text Printed to Pasteboard]")
    
    let pasteBoard = UIPasteboard.general
    pasteBoard.string = text
    #endif
    
}
