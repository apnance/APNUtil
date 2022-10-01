//
//  RoundImageView.swift
//  APNUtil
//
//  Created by Aaron Nance on 6/28/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import UIKit

/// A subclass of UIView that renders round by setting layer.cornerRadius to one half the smaller frame dimension.
/// - important: to specify a view diameter use the convenience initializer, else the diameter is set as one
/// half the smaller of the two frame dimensions.
@IBDesignable open class RoundImageView: UIImageView {
    
    // MARK: - Overrides
    override init(frame: CGRect) {
        
        super.init(frame: frame)
                
        setRadius()
        
    }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        setRadius()
        
    }

    public override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        
        let dim = min(frame.width, frame.height)
        
        frame = CGRect(origin: frame.origin,
                       size: CGSize(width: dim, height: dim))
        
        layer.cornerRadius = dim / 2
        
    }
    
    
    // MARK: - Custom Methods
    private func setRadius() {
        
        layer.cornerRadius = min(frame.width, frame.height) / 2
        
    }
    
}
