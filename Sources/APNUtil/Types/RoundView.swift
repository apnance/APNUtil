//
//  RoundView.swift
//  APNUtil
//
//  Created by Aaron Nance on 6/28/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import UIKit

/// A subclass of UIView that renders round by setting layer.cornerRadius to one half the smaller frame dimension.
/// - important: to specify a view diameter use the convenience initializer, else the diameter is set as one
/// half the smaller of the two frame dimensions.
@IBDesignable open class RoundView: UIView {
    
    // MARK: - Overrides
    override init(frame: CGRect) {
        
        super.init(frame: frame)
                
        setRadius()
        
    }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        setRadius()
        
    }
    
    open override func layoutSubviews() {
        
        setRadius()
        
        super.layoutSubviews()
        
    }
    open override func didMoveToSuperview() { setRadius() }
    
    /// - note: to add a dashed border specify a borderPattern.
    public convenience init(diameter: CGFloat,
                            backgroundColor bgColor: UIColor = UIColor.clear,
                            borderWidth: Double = 0,
                            borderColor: UIColor = .clear,
                            borderPattern: [NSNumber]? = nil,
                            centeredAt center: CGPoint? = nil) {
        
        let frame = CGRect(x: 0, y: 0,
                           width: diameter, height: diameter)
        
        self.init(frame: frame,
                  cornerRadius: diameter / 2,
                  backgroundColor: bgColor,
                  borderWidth: borderWidth,
                  borderColor: borderColor,
                  borderPattern: borderPattern)
        
        self.center = center ?? self.center
        
    }
    
    public override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        
        let dim = min(frame.width, frame.height)

        frame = CGRect(origin: frame.origin,
                       size: CGSize(width: dim, height: dim))
        
        setRadius()
        
    }
    
    
    // MARK: - Custom Methods
    /// Sets radius of view based on the view's current frame dimensions.
    /// - important: Call this after views are layed out if the view doesn't appear round.
    public func setRadius() {
        
        roundify()
        
    }
    
}

/// A subclass of `RoundView` that allows touches to pass through itself.
@IBDesignable open class RoundIgnoreTouchView: RoundView {
    
    public override func hitTest(_ point: CGPoint,
                                 with event: UIEvent?) -> UIView? {
     
        let hitView = super.hitTest(point, with: event)
        
        return ( hitView == self ? nil : hitView )
        
    }
    
}
