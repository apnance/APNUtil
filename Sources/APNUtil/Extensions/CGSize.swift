//
//  CGSize.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/9/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import UIKit

public extension CGSize {

    /// Aspect ratio
    var aspect: Double { Double(width / height) }
    
    /// Returns  a new `CGSize` with height and width multiplied by `scaleFactor`
    func scaledBy(_ factor: Double) -> CGSize {
        
        let scale = CGFloat(factor)
        
        return CGSize(width: width * scale,
                      height: height * scale)
        
    }
    
    /// Returns a copy of self with `height` set to `newHeight`
    func with(newHeight: CGFloat) -> CGSize {
        
        CGSize(width: width, height: newHeight)
        
    }

    /// Returns a copy of self with `width` set to `newWidth`
    func with(newWidth: CGFloat) -> CGSize {
        
        CGSize(width: newWidth, height: height)
        
    }
    
}
