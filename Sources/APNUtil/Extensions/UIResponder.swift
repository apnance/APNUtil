//
//  UIResponder.swift
//  APNUtil
//
//  Created by Aaron Nance on 8/25/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import UIKit

public extension UIResponder {
        
    // credit: https://swiftrocks.com/understanding-the-ios-responder-chain.html
    /// Returns a `String` representation of the responder chain for a given `UIResponder`
    func responderChain() -> String {
        
        guard let next = next
        else { return String(describing: self) }
        
        return "\(type(of: self)) -> \(next.responderChain())"
        
    }
    
}
