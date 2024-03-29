//
//  UIView.swift
//  APNUtil
//
//  Created by Aaron Nance on 5/1/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import UIKit

// MARK: - General Utility
public extension UIView {
    
    /// Convenience initializer for creatig views with rounded corners and/or border patterns
    convenience init(frame: CGRect,
                     cornerRadius: CGFloat = 0,
                     backgroundColor: UIColor = .clear,
                     borderWidth: Double = 0,
                     borderColor: UIColor = .clear,
                     borderPattern: [NSNumber]? = nil) {
        
        self.init(frame: frame)
        
        self.layer.backgroundColor  = backgroundColor.cgColor
        self.layer.cornerRadius     = cornerRadius
        
        if let borderPattern = borderPattern {
            
            addDashedBorder(borderColor,
                            width: borderWidth,
                            dashPattern: borderPattern)
            
        } else {
            
            self.layer.borderWidth = borderWidth.cgFloat
            self.layer.borderColor = borderColor.cgColor
            
        }
        
    }
    
    /// Returns a reference to the `UIViewController` presenting this `UIView`
    var currentViewController: UIViewController? {
        
        func getCurrentViewController(vc: UIViewController? = nil) -> UIViewController? {
            
            if vc == nil {
                
                guard let rvc = UIApplication.shared.keyWindow?.rootViewController
                else { return nil /*EXIT*/ }
                
                return getCurrentViewController(vc: rvc) /*EXIT*/
                
            }
            
            if let pvc = vc?.presentedViewController , !pvc.isBeingDismissed {
                
                return getCurrentViewController(vc: pvc) /*EXIT*/
                
            }
            else if let svc = vc as? UISplitViewController , svc.viewControllers.count > 0 {
                
                return getCurrentViewController(vc: svc.viewControllers.last!) /*EXIT*/
                
            }
            else if let nc = vc as? UINavigationController , nc.viewControllers.count > 0 {
                
                return getCurrentViewController(vc: nc.topViewController!) /*EXIT*/
                
            }
            else if let tbc = vc as? UITabBarController {
                
                if let svc = tbc.selectedViewController {
                    
                    return getCurrentViewController(vc: svc) /*EXIT*/
                    
                }
            }
            
            return vc /*EXIT*/
            
        }
        
        return getCurrentViewController() /*EXIT*/
        
    }
    
    /// Removes ALL subview from the `UIView`
    func removeAllSubviews() { for view in subviews { view.removeFromSuperview() } }
        
    /// Toggles hidden value
    func toggleHidden() { self.isHidden = !self.isHidden }
    
}

// MARK: - Animation


public extension UIView {
    
    typealias AnimationFrame = (startTime: Double, duration: Double, keyFrame: () -> ())
    
    /// Facilitates the creation of elaborate `View` keyframe animations by simplifying the interface.  To create
    /// a 10s animation with multiple frames of differing relative lengths you simply specify the total animation
    /// duration and pass in an array of key frames with relative lengths.  This method normalizes your relative
    /// runtimes for you  and runs your animation before calling  your completion handler.(see sample for usage details).
    ///
    /// - Parameters:
    ///   - duration: total animation time in seconds.
    ///   - delay: time in seconds to wait before beginning animation.
    ///   - frames: `[AnimationFrame]` the key to streamlining the animation process.
    ///   (see note below for explanation of `AnimationFrame` syntax.)
    ///   - completion: handler to be called at the end of animation.
    ///
    /// # Example #
    /// ```swift
    ///        // Sample Usage:
    ///        //
    ///        // In this example we create a 10s animation with a 2s delay.
    ///        //
    ///        // 1. at 0s mainTitle begins to slowly fade over 5s.
    ///        // 2. at 4s (5s for end of previous frame -1s for start of this frame)
    ///        //    widgetView begins to materialize over 3s
    ///        // 3. finally at 7s(end of previous frame + 0s) greebleView begins
    ///        //    to fade out over the remaining 3s of the animation.
    ///        //
    ///        // NOTE 1: the total runtime would be 11s except that frame 2 starts
    ///        //         1 second before the end of frame 1.
    ///        //
    ///        // NOTE 2: it is not necessary to make your relative frame durations equal
    ///        //         your total animation runtime, here the animation time
    ///        //         is 10s and the total relative frame durations (allowing
    ///        //         for negative starttime offset of frame 2) total to 10 simply
    ///        //         for simplicity of demonstration.
    ///        //
    ///        UIView.buildAnimation(withDuration: 10.0,
    ///        delay: 2.0,
    ///        withFrames: [(0.0, 5, { self.mainTitle.alpha = 0.0 }),
    ///                     (-1.0, 3, { self.widgetView.alpha = 1.0 }),
    ///                     (0.0, 3, { self.greebleView.alpha = 0.0 }), ],
    ///        completionHandler: { finished _ in /*clean up here*/ })
    /// ```
    ///
    /// - note: `AnimationFrame` has the following structure:
    /// `startTime` - is a double representing the *relative* length of time since the end of the last frame to begin this frame.
    /// This number can be negative in which case this frame begins before the last frame ends by the difference
    /// between the end time of the previous frame and the negative start time of this frame.
    /// `duration` - specifies *relative* length of time over which this  animation frame will animate.
    /// `keyFrame` - is a closure containing the new value to animate toward.
    static func buildAnimation(withDuration duration: Double,
                        delay: Double,
                        withFrames frames: [AnimationFrame],
                        completionHandler completion: ((Bool) -> ())?) {
        
        var frames          = frames
        
        var totalDuration   = 0.0
        var previousEndTime = 0.0
        
        for (i, frame) in frames.enumerated() {
            
            let currentDuration     = frame.1
            let currentStartTime    = previousEndTime + frame.0
            previousEndTime         = currentStartTime + currentDuration
            
            assert(currentDuration >= 0, "Start Time[\(frame.0)] + Duration[\(frame.1)] == \(currentDuration) but must be >= 0")
            
            totalDuration = max(currentStartTime + currentDuration, totalDuration)
            
            frames[i].startTime = currentStartTime
            frames[i].duration  = currentDuration
            
        }
        
        assert(totalDuration > 0, "Total Duration[\(totalDuration)] == \(totalDuration) but must be > 0")
        
        animateKeyframes(withDuration:  duration,
                         delay:         delay,
                         options:       .calculationModeLinear,
                         animations: {
            
            for frame in frames {
                
                let start       = frame.0 / totalDuration
                let duration    = frame.1 / totalDuration
                let animations  = frame.2
                
                assert(start + duration <= 1.0)
                
                addKeyframe(withRelativeStartTime:  start,
                            relativeDuration:       duration,
                            animations:             animations) } },
                         completion: completion)
        
    }
    
}


// MARK: - Imaging
public extension UIView {
    
    /// Returns a `UIImage` snapshot of the this view including its subviews.
    /// - important: Not specifically calling this property from the main thread could result in blank
    /// UIImages being returned.
    var imageCapture: UIImage? {
        
        let size = CGSize(width: frame.size.width, height: frame.size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        drawHierarchy(in: CGRect(x: 0.0,
                                 y: 0.0,
                                 width: frame.size.width,
                                 height: frame.size.height),
                      afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysTemplate)
        
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    /// Returns a PNG based `UIImage` snapshot of the this view including its subviews.
    /// - important: Not specifically calling this property from the main thread could result in blank
    /// UIImages being returned.
    var imageCaptureAsPNG: UIImage? {
        
        guard let pngData = imageCapture?.pngData()
        else { return nil /*EXIT*/ }
        
        return UIImage(data: pngData)
        
    }
    
    /// Renders UIView and all of its subviews as monochromatic.
    func monochromize( _ color: UIColor) {
        
        layer.borderColor = color.cgColor
        
        for sv in subviews {
            
            sv.monochromize(color)
            
        }
        
        if let img = self as? UIImageView {
            
            img.tintColor = color
            
        }
        else if let txt = self as? UILabel {
            
            txt.textColor = color
            
        }
        else if let bgColor = backgroundColor {
            
            switch bgColor {
                
            case .white: break
                
            case .clear: break
                
            case .black: backgroundColor = color
                
            default: backgroundColor = .white
                
            }
            
        }
        
    }
    
}

// MARK: - Frame Modifications
public extension UIView {
        
    //
    //  user Mazyod:
    //  https://stackoverflow.com/questions/3605393/iphone-uiview-resize-frame-to-fit-subviews
    /// Resizes frame to contain all subviews.
    /// NOTE: initial tests indicate a problem with offsets
    func resizeToFitSubviews() {
        
        assert(false, "Deprecated: Check that \(#function) works as intended.")
        
        let subviewsRect = subviews.reduce(CGRect.zero) { $0.union($1.frame) }
        
        let fix = subviewsRect.origin
        subviews.forEach {
            
            // NOTE: $0.frame.offsetBy(dx: -fix.x, dy: -fix.y) now throws warning
            //      if result not assigned. Was offsetBy(dx: dy) changed to not
            //      act on the receiver?
            _ = $0.frame.offsetBy(dx: -fix.x, dy: -fix.y)
            
        }
        
        // NOTE: $0.frame.offsetBy(dx: -fix.x, dy: -fix.y) now throws warning if
        //      result not assigned. Was offsetBy(dx: dy) changed to not act on
        //      the receiver?
        _ = frame.offsetBy(dx: fix.x, dy: fix.y)
        frame.size = subviewsRect.size
        
    }
    
    var boundsCenter: CGPoint { CGPoint(x: bounds.width / 2, y: bounds.height / 2) }
    
    /// Moves the UIView's center to specified x and y coordinates.
    func recenterTo(x: Double? = nil, y: Double? = nil) {
        
        let x = x != nil ? CGFloat(x!) : center.x
        let y = y != nil ? CGFloat(y!) : center.y
        
        recenterTo(x: x, y: y)
        
    }
    
    /// Moves the UIView's center to specified x and y coordinates.
    func recenterTo(x: CGFloat? = nil, y: CGFloat? = nil) {
        
        let x = x ?? self.center.x
        let y = y ?? self.center.y
        
        center = CGPoint(x: x, y: y)
        
    }
    
}

// MARK: - Transforms
public extension UIView {
    
    func rotate(angle: Double) {
        
        transform = transform.rotated(by: angle.degreesToRadians.cgFloat)
        
    }
    
    func resetTranform() {
        
        transform = CGAffineTransform.identity
        
    }
    
    /// Rotates a view randomly between (angle - variability) and (angle + variability)
    func rotate(angle: Double, withRandomVariability variability: Double) {
        
        rotateRandom(minAngle: angle - variability,
                     maxAngle: angle + variability)
        
    }
    
    func rotate(view: UIView, rotateFunction: () -> Double) {
        
        let angle = rotateFunction()
        rotate(angle: angle)
        
    }
    
    func rotateRandom(minRotation min: Double, maxRotation max: Double) {
        
        rotate(angle: Double.random(min: min, max: max))
        
    }
    
    func rotateRandom(minAngle: Double, maxAngle: Double) {
        
        let angle = Double.random(min: minAngle, max: maxAngle)
        
        let degrees = CGFloat(angle * Double.pi/180.0)
        transform = CGAffineTransform(rotationAngle: degrees)
        
    }
    
    /// Rotates the UIView randomly within either the minRange or maxRange.
    ///
    /// Useful excluding intermediary random values if for instance you wish to have a view rotated wither
    /// heavily right or heavily left but not in between.
    func rotateRandom(minRange: ClosedRange<Double>, maxRange: ClosedRange<Double>) {
        
        let range = Bool.random() ? minRange : maxRange
        
        rotateRandom(minAngle: range.lowerBound, maxAngle: range.upperBound)
        
    }
    
}

// MARK: - Constraints
public extension UIView {
    
    /// Sets this view's `topAnchor`, `trailingAnchor`, `bottomAnchor`, `leadingAnchor`
    /// equal to those of `superview`.
    /// - important: This method sets `translatesAutoresizingMaskIntoConstraints` to `false`
    /// - note: This method does nothing if superview is nil, including setting `translatesAutoresizingMaskIntoConstraints`
    func constrainToFillSuperview() {
        
        if superview != nil {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            topAnchor.constraint(equalTo: superview!.topAnchor).isActive = true
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor).isActive = true
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor).isActive = true
            
        }
        
    }
    
    
    /// Adds this `UIView` to `container`'s subviews and sets it's four edge constraints equal to `container`'s
    /// - Parameter container: container UIView in which to embed this view.
    func constrainIn(_ container: UIView!) {
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        
        container.addSubview(self);
        
        topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        
    }
    
}

// MARK: - Layer Manipulation
public extension UIView {
    
    /// Renders layer as circle by setting radius to be half the smaller dimension(height or width)
    ///
    /// - note: view will not render as round if clipsToBounds is not set to true.
    func roundify(setClipsToBounds: Bool = false) {
        
        if setClipsToBounds { clipsToBounds = true }
        
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        
    }
    
    /// Adds a color gradient to the `UIView` from `startColor` to `endColor` with gradient
    /// orientation specified by `isHorizontal` which defaults to vertical,
    func addGradient(startColor: UIColor, endColor: UIColor, isHorizontal: Bool = false ) {
        
        addGradient(colors: [startColor.cgColor, endColor.cgColor], isHorizontal: isHorizontal)
        
    }

    /// Adds a color gradient to the `UIView` using `colors` with gradient orientation specified by
    /// `isHorizontal` which defaults to vertical,
    func addGradient(colors: [CGColor], isHorizontal: Bool = false ) {
        
        removeGradient()
  
        let grad = CAGradientLayer()
        
        if isHorizontal {
            
            grad.transform = CATransform3DMakeRotation(CGFloat.pi / -2, 0, 0, 1)
            
        }
        grad.name = "APNGradLayer"
        grad.frame = frame
        grad.frame.origin.y = 0
        
        grad.colors = colors
                
        layer.insertSublayer(grad, at: 0)
        
    }
    
    /// Attempts to remove a gradient that has been added via one of the addGradient methods.
    /// - note: has no effect if no gradient has been added or has already been removed.
    func removeGradient() {
        
        if let sublayers = layer.sublayers {
            
            for sub in sublayers {
                if sub.name == "APNGradLayer" { sub.removeFromSuperlayer() }
            }
            
        }
        
    }
    
    // modified from https://stackoverflow.com/questions/13679923/dashed-line-border-around-uiview
    /// Adds a dashed border `CAShapeLayer` sublayer to the `sublayers` array.
    /// - important: Any existing dashed border(s) is(are) removed upon successive calls to this method
    /// before a new one is added.
    ///
    /// - note: To remove this dashed border call `removeDashedBorder()`
    ///
    /// # Example #
    /// ```swift
    ///  // Example - Add a dotted line border with dots 5pts in diameter
    ///  // spaced 12 pts.
    /// someView.addDashedBorder(.white,
    ///                           width: 5,
    ///                           dashPattern: [0.1,12],
    ///                           lineCap: .round)`
    /// ```
    func addDashedBorder(_ color: UIColor = .black,
                         width: Double = 2.0,
                         dashPattern: [NSNumber] = [10,5],
                         lineCap: CAShapeLayerLineCap = .butt) {
        
        // Clear pre-existing dashed border(s)
        removeDashedBorder()
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0,
                               width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width.cgFloat
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineCap = lineCap
        shapeLayer.lineDashPattern = dashPattern
        
        if layer.cornerRadius == 0 {
            
            shapeLayer.path = UIBezierPath(rect: shapeRect).cgPath
            
        } else {
            
            shapeLayer.path = UIBezierPath(roundedRect: shapeRect,
                                           cornerRadius: layer.cornerRadius ).cgPath
            
        }
        
        shapeLayer.name = "apn_addedDashedBorderLayer"
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    /// Adds a dashed line `CAShapeLayer` sublayer to the `sublayers` array.
    /// - important: Any existing dashed line(s) is(are) removed upon successive calls to this method
    /// before a new one is added.
    /// - note: To remove this dashed border call `removeDashedLine()`
    /// 
    /// # Example #
    /// ```swift
    ///  // Example - Add a dotted horizontal line centered vertically with dots 5pts in diameter
    ///  // spaced 12 pts.
    /// someView.addDashedLine(.white,
    ///                        width: 5,
    ///                        dashPattern: [0.1,12],
    ///                        lineCap: .round,
    ///                        horizonal: true)`
    /// ```
    func addDashedLine(_ color: UIColor = .black,
                       width: Double = 2.0,
                       dashPattern: [NSNumber] = [10,5],
                       lineCap: CAShapeLayerLineCap = .butt,
                       isHorizontal: Bool) {
        
        // Clear pre-existing dashed line(s)
        removeDashedLine()
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0,
                               width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width.cgFloat
        shapeLayer.lineCap = lineCap
        shapeLayer.lineDashPattern = dashPattern
        
            let linePath = UIBezierPath()
            
            if isHorizontal {

                linePath.move(to: CGPoint(x: 0, y: frameSize.height / 2))
                
                linePath.addLine(to: CGPoint(x: self.frame.width, y: frameSize.height / 2))
                
            } else {
                
                linePath.move(to: CGPoint(x: frameSize.width / 2, y: 0))
                linePath.addLine(to: CGPoint(x: frameSize.width / 2, y: self.frame.height))
                
            }
        
        shapeLayer.path = linePath.cgPath
        
        shapeLayer.name = "apn_addedDashedLineLayer"
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    
    /// Removes all dashed borders by removing them from `sublayers`.
    /// - note: Dashed borders are given the name "apn_addedDashedBorderLayer", only layers with that
    /// name are removed from `sublayers`
    func removeDashedBorder() {
        
        layer.sublayers?.forEach{
            
            if $0.name == "apn_addedDashedBorderLayer" { layer.sublayers?.remove($0) }
            
        }
        
    }
    
    /// Removes all dashed lines by removing them from `sublayers`.
    /// - note: Dashed borders are given the name "apn_addedDashedBorderLayer", only layers with that
    /// name are removed from `sublayers`
    func removeDashedLine() {
        
        layer.sublayers?.forEach{
            
            if $0.name == "apn_addedDashedLineLayer" { layer.sublayers?.remove($0) }
            
        }
        
    }
    
    
    func addShadows(width: CGFloat = 10.0,
                    height: CGFloat = 4.0,
                    withOpacity opacity: Double = 0.3) {
        
        layer.masksToBounds = false
        layer.shadowOpacity = Float(opacity)
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: width,
                                        height: height)
        
    }
    
    func removeShadows(from: UIView) { addShadows(withOpacity: 0.0) }
    
}
