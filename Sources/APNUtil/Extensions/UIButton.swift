//
//  UIButton.swift
//  APNUtil
//
//  Created by Aaron Nance on 2/4/21.
//  Copyright © 2021 Aaron Nance. All rights reserved.
//

import UIKit

public extension UIButton {
    
    /// Scales the `titleLabel`'s font by the specified factor.
    func scaleFont(by scaleFactor: CGFloat) {
        
        let title = titleLabel!
        
        title.font = UIFont(name: title.font!.familyName,
                            size: bounds.height * scaleFactor)!
        
    }
    
    func addLabel(_ text: String,
                  color: UIColor = .black,
                  alignment: NSTextAlignment = .center,
                  font: UIFont? = nil,
                  shadowOffset: CGSize = CGSize.zero,
                  shadowColor: UIColor = UIColor.black,
                  shadowOpacity: Double = 0.5) {
        
        removeLabel()
        
        let label = UILabel()
        label.tag = 1279
        label.text = text
        label.textColor = color
        label.textAlignment = alignment
        
        let font = font ?? CTFontCreateWithName("System-Bold" as CFString, 12, nil)
        
        
        label.font = font
        label.adjustsFontSizeToFitWidth = true
        
        if shadowOffset != .zero {
            
            label.layer.shadowColor   = shadowColor.cgColor
            label.layer.shadowOffset  = shadowOffset
            label.layer.shadowOpacity = Float(shadowOpacity)
            
        }
        
        addSubview(label)
        bringSubviewToFront(label)
        
        label.constrainToFillSuperview()
        
    }
    
    /// Removes any label(s) added to this UIButton via the addLabel(_:_:_:_:) method
    func removeLabel() {
        
        subviews.forEach{ if $0.tag == 1279 { $0.removeFromSuperview() } }
        
    }
    
}
