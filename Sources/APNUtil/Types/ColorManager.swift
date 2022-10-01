//
//  ColorManager.swift
//  APNUtil
//
//  Created by Aaron Nance on 7/22/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import UIKit

/// ColorManager singleton is used to color code things for purpose of debugging.
public class ColorManager {
    
    // MARK: - Properties
    /// Singleton access.
    public static var shared = ColorManager()
    
    private var colorIndex = -1
    
    private var colors = [UIColor.red,
                          .orange,
                          .yellow,
                          .green,
                          .blue,
                          .purple]
    
    
    // MARK: - Custom Methods
    
    /// Call this to reset color index to beginning.
    public func resetColors() { colorIndex = -1 }
    
    /// Calling this gets next color in rainbow looping back to red after purple.
    public var nextColor: UIColor {
        
        colorIndex = colorIndex == colors.lastUsableIndex ? 0 : colorIndex + 1
        
        return colors[colorIndex]
        
    }
    
    public func set(colors: [UIColor]) { self.colors = colors }
    
}
