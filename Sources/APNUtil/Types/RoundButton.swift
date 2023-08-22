//
//  RoundView.swift
//  APNUtil
//
//  Created by Aaron Nance on 6/28/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import UIKit

/// A subclass of UIView that renders round.
/// - important: use convenience initializer
/// `init(diameter: backgroundColor: borderWidth: borderColor: borderPattern: centeredAt:)`
@IBDesignable open class RoundButton: UIButton {
    
    // MARK: - Properties
    public private(set) var diameter: CGFloat = 0
    
    
    // MARK: - Overrides
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
        
        self.diameter = diameter
        
    }
    
    
    // MARK: - Custom Methods
    public override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        
        initUI()
        
    }
    
    public override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        
        initUI()
        
    }
    
    private func initUI() {
        
        let dim = min(frame.width, frame.height)
        
        let size = CGSize(width: dim,
                          height: dim)
        
        frame = CGRect(origin: frame.origin,
                       size: size)
        
        layer.cornerRadius = dim / 2
        
        addTarget(self,
                  action: #selector(addHaptic),
                  for: .touchUpInside)
        
    }
    
    @objc func addHaptic() { haptic(withStyle: .light) }
    
}
