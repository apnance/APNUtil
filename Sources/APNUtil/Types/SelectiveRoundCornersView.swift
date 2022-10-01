//
//  RoundedTopRightView.swift
//  Banker's Buddy
//
//  Created by Aaron Nance on 2/16/21.
//  Copyright © 2021 Aaron Nance. All rights reserved.
//

import UIKit

@IBDesignable open class SelectiveRoundCornersView: UIView {
    
    // MARK: - Properties
    @IBInspectable public var cornerRadius: Double = 20
    @IBInspectable public var roundTL: Bool        = false
    @IBInspectable public var roundTR: Bool        = false
    @IBInspectable public var roundBR: Bool        = false
    @IBInspectable public var roundBL: Bool        = false
    @IBInspectable public var clips: Bool          = true
    
    
    // MARK: - Overrides
    public override func layoutSubviews() { initUI() }
    
    public override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        
        initUI()
        
    }
    
    
    // MARK: - Custom Methods
    private func initUI() {
        
        var mask = CACornerMask()

        if roundTL { mask.insert(.layerMinXMinYCorner)}
        if roundTR { mask.insert(.layerMaxXMinYCorner)}
        if roundBR { mask.insert(.layerMaxXMaxYCorner)}
        if roundBL { mask.insert(.layerMinXMaxYCorner)}
        
        layer.maskedCorners = mask
                
        layer.cornerRadius  = cornerRadius.cgFloat
                
        clipsToBounds       = clips
        
    }
    
}
