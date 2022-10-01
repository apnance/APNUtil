//
//  IgnoreTouchView.swift
//  APNUtil
//
//  Created by Aaron Nance on 6/28/20.
//  source: user Kevin https://stackoverflow.com/questions/7719412/how-to-ignore-touch-events-and-pass-them-to-another-subviews-uicontrol-objects
//

import UIKit

/// A subclass of UIView that ignores touch events allowing them to pass through to views below it in the view
/// hierarchy.
open class IgnoreTouchView: UIView {
    
    public override func hitTest(_ point: CGPoint,
                                 with event: UIEvent?) -> UIView? {
        
        let hitView = super.hitTest(point, with: event)
        
        return ( hitView == self ? nil : hitView )
        
    }
    
}
