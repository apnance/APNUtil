//
//  RoundTextView.swift
//  APNUtil
//
//  Created by Aaron Nance on 8/1/24.
//
// Rounded Text Source: https://stackoverflow.com/questions/32771864/draw-text-along-circular-path-in-swift-for-ios?noredirect=1&lq=1

import UIKit

/// Creates rounded text that follows the circle inscribed in `self` with optional configurable rounded background.
@IBDesignable
open class RoundTextView: UIView {
    
    // Text
    /// Angle to rotate text from being centered horizontally.
    @IBInspectable var degreesOffset: Double    = 0
    
    /// The text to be circularly inscribed in `self`'s bounds.
    @IBInspectable var roundedText: String      = "👉Your Text Here👈"
    
    @IBInspectable var fontName: String         = "Verdana"
    @IBInspectable var fontSize: Double         = 24
    @IBInspectable var textColor: UIColor       = .green
    
    // Circular BG
    @IBInspectable var bgRadius: Double         = 0
    @IBInspectable var bgColor: UIColor         = .blue
    @IBInspectable var bgStrokeColor: UIColor   = .red
    @IBInspectable var bgStrokeWidth: CGFloat   = 20.0
    
    /// Angle to render text off-center from top.  If set to 0, the text is centered horizontally along top of view.
    private var renderAngle: Double { (CGFloat.pi / 2.0) - (degreesOffset * ((CGFloat.pi * 2) / 360.0 )) }
    private lazy var font = UIFont(name: fontName, size: fontSize)!
    
    public override func draw(_ rect: CGRect) {
        
        // TODO: Clean Up - delete
        // let containsLowerCase = text.contains(/[yjpq]+/) //.contains("[yqpj]", options: .regularExpression)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let size                = self.bounds.size
        
        let viewRadius          = rect.width / 2.0
        let fontHeight          = font.capHeight
        let textRadius          = viewRadius - (fontHeight / 2.0)
        let circleBGRadius      = viewRadius - fontHeight + bgRadius
        
        addCircularBG(withRadius: circleBGRadius,
                      inRect: rect,
                      context: context)
        
        // Save Context
        context.saveGState()
        
        // Transforming Context
        context.translateBy (x: size.width / 2, y: size.height / 2)
        context.scaleBy (x: 1, y: -1)
        
        centreArcPerpendicular(text: roundedText,
                               context: context,
                               radius: textRadius,
                               angle: renderAngle,
                               colour: textColor,
                               font: font,
                               clockwise: true)
        
        // Save Context
        context.restoreGState()
        
        
    }
    
    func centreArcPerpendicular(text str: String,
                                context: CGContext,
                                radius r: CGFloat,
                                angle theta: CGFloat,
                                colour c: UIColor,
                                font: UIFont,
                                clockwise: Bool,
                                kern: CGFloat = 0) {
        
        // *******************************************************
        // This draws the String str around an arc of radius r,
        // with the text centred at polar angle theta
        // *******************************************************
        
        func chordToArc(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
            return 2 * asin(chord / (2 * radius))
        }
        
        let characters: [String] = str.map { String($0) } // An array of single character strings, each character in str
        let l = characters.count
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.kern: kern] as [NSAttributedString.Key : Any]
        
        var arcs: [CGFloat] = [] // This will be the arcs subtended by each character
        var totalArc: CGFloat = 0 // ... and the total arc subtended by the string
        
        // Calculate the arc subtended by each letter and their total
        for i in 0 ..< l {
            arcs += [chordToArc(characters[i].size(withAttributes: attributes).width, radius: r)]
            totalArc += arcs[i]
        }
        
        // Are we writing clockwise (right way up at 12 o'clock, upside down at 6 o'clock)
        // or anti-clockwise (right way up at 6 o'clock)?
        let direction: CGFloat = clockwise ? -1 : 1
        let slantCorrection: CGFloat = clockwise ? -.pi / 2 : .pi / 2
        
        // The centre of the first character will then be at
        // thetaI = theta - totalArc / 2 + arcs[0] / 2
        // But we add the last term inside the loop
        var thetaI = theta - direction * totalArc / 2
        
        for i in 0 ..< l {
            thetaI += direction * arcs[i] / 2
            // Call centerText with each character in turn.
            // Remember to add +/-90º to the slantAngle otherwise
            // the characters will "stack" round the arc rather than "text flow"
            centre(text: characters[i],
                   context: context,
                   radius: r,
                   angle: thetaI,
                   colour: c,
                   font: font,
                   slantAngle: thetaI + slantCorrection,
                   kern: kern)
         
            // The centre of the next character will then be at
            // thetaI = thetaI + arcs[i] / 2 + arcs[i + 1] / 2
            // but again we leave the last term to the start of the next loop...
            thetaI += direction * arcs[i] / 2
        }
    }
    
    func centre(text str: String,
                context: CGContext,
                radius r: CGFloat,
                angle theta: CGFloat,
                colour c: UIColor,
                font: UIFont,
                slantAngle: CGFloat,
                kern: CGFloat) {
        // *******************************************************
        // This draws the String str centred at the position
        // specified by the polar coordinates (r, theta)
        // i.e. the x= r * cos(theta) y= r * sin(theta)
        // and rotated by the angle slantAngle
        // *******************************************************
        
        // Set the text attributes
        let attributes = [NSAttributedString.Key.foregroundColor: c,
                          NSAttributedString.Key.font: font,
                          NSAttributedString.Key.kern: kern] as [NSAttributedString.Key : Any]
        
        //let attributes = [NSForegroundColorAttributeName: c, NSFontAttributeName: font]
        // Save the context
        context.saveGState()
        // Undo the inversion of the Y-axis (or the text goes backwards!)
        context.scaleBy(x: 1, y: -1)
        // Move the origin to the centre of the text (negating the y-axis manually)
        context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
        // Rotate the coordinate system
        context.rotate(by: -slantAngle)
        // Calculate the width of the text
        let offset = str.size(withAttributes: attributes)
        // Move the origin by half the size of the text
        context.translateBy (x: -offset.width / 2, y: -offset.height / 2) // Move the origin to the centre of the text (negating the y-axis manually)
        // Draw the text
        str.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        
        // Restore the context
        context.restoreGState()
        
    }
    
    func addCircularBG(withRadius radius: CGFloat,
                       inRect rect: CGRect,
                       context: CGContext) {
        
        let containingRect  = CGRect(x: rect.midX - radius, y: rect.midY - radius,
                                     width: radius * 2, height: radius * 2)
        
        let path            = UIBezierPath(ovalIn: containingRect)
        
        context.setFillColor(bgColor.cgColor)
        context.setStrokeColor(bgStrokeColor.cgColor)
        path.lineWidth = bgStrokeWidth
        path.fill()
        path.stroke()
        
        context.fillPath()
        
    }
    
}
