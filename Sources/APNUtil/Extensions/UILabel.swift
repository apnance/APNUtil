//
//  Font.swift
//  APNUtil
//
//  Created by Aaron Nance on 1/30/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import UIKit

public extension UILabel {
    
    /// Returns the `CGSize` of the UILabel allowing for font size and text value.
    func size() -> CGSize {
        
        var size = CGSize.zero
        
        if let font = self.font {
            
            let fontAttributes = [NSAttributedString.Key.font: font]
            let text = self.text ?? ""
            size = (text as NSString).size(withAttributes: fontAttributes)
            
        }
        
        return size
        
    }
    
}
