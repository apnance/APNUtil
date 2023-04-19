//
//  CircleGraphView.swift
//  Swift Ring Graph
//
//  Created by Steven Lipton on 3/10/15.
//  Updated/Modfied by Aaron Nance on 04/18/23
//  Source: https://makeapppie.com/2015/03/10/swift-swift-basic-core-graphics-for-the-ring-graph/
//  Copyright (c) 2015 MakeAppPie.Com. All rights reserved.
//
 
import UIKit
 
class CircleGraphView: UIView {
    
    var endArc:CGFloat = 0.8 {   // in range of 0.0 to 1.0
        
        didSet{ setNeedsDisplay() }
        
    }
    
    var arcColor: UIColor = .green { didSet { setNeedsDisplay() } }
    
    var arcWidth:CGFloat = 15.0
    var arcBackgroundColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        
        //Important constants for circle
        let fullCircle      = 2.0 * CGFloat(Double.pi)
        let start:CGFloat   = -0.25 * fullCircle
        let end: CGFloat    = endArc * fullCircle + start
        
        //find the centerpoint of the rect
        let centerPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        
        //define the radius by the smallest side of the view
        var radius:CGFloat = 0.0
        
        if CGRectGetWidth(rect) > CGRectGetHeight(rect){
            
            radius = (CGRectGetWidth(rect) - arcWidth) / 2.0
            
        }else{
            
            radius = (CGRectGetHeight(rect) - arcWidth) / 2.0
            
        }
        
        //starting point for all drawing code is getting the context.
        let context = UIGraphicsGetCurrentContext()!
        
        //set line attributes
        context.setLineWidth(arcWidth)
        context.setLineCap(CGLineCap.round)
        
        //make the circle background
        context.setStrokeColor(arcBackgroundColor.cgColor)
        context.addArc(center: centerPoint,
                       radius: radius,
                       startAngle: 0,
                       endAngle: fullCircle,
                       clockwise: false)
        
        context.strokePath()
        
        //draw the arc
        context.setStrokeColor(arcColor.cgColor)
        context.setLineWidth(arcWidth * 0.8 )
        
        //CGContextSetLineWidth(context, arcWidth)
        context.addArc(center: centerPoint,
                       radius: radius,
                       startAngle: start,
                       endAngle: end,
                       clockwise:false)
        
        context.strokePath()
        
    }
    
}

