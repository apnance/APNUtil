//
//  UIImage.swift
//  APNUtil
//
//  Created by Aaron Nance on 4/23/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /// Attempts to initialize an Image looking for the image in the specified subPath of the document directory.
    convenience init?(withSubPath: String) {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = FileManager.cleanFilePath("\(paths[0])/\(withSubPath)")
        
        self.init(contentsOfFile: path)
        
    }
    
    /// Attempts to write the contents of the `UIImage` to the specified namd and sub directory of the couments directory.
    /// - returns: a boolean indicating success of the write attempt.
    func writeToFile(fileName: String, subDir: String) -> Bool {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        // Save image.
        do {
            
            try FileManager.createSubDir(subDir)
            
            let filePath = FileManager.cleanFilePath("\(paths[0])/\(subDir)\(fileName)")
            
            let fileURL = URL(fileURLWithPath: filePath)
            
            try pngData()?.write(to: fileURL, options: .atomic)
            
        } catch {
            
            print("Error saving file: \(error)")
            return false /*EXIT*/
            
        }
        
        return true /*EXIT*/
        
    }
    
    // source: https://stackoverflow.com/questions/158914/cropping-an-uiimage
    
    /// Returns an image cropped to the specified CGRect
    func crop(rect: CGRect) -> UIImage? {
        
        var scaledRect = rect
        scaledRect.origin.x *= scale
        scaledRect.origin.y *= scale
        scaledRect.size.width *= scale
        scaledRect.size.height *= scale
        
        guard let imageRef: CGImage = cgImage?.cropping(to: scaledRect) else {
            
            return nil
            
        }
        
        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
        
    }
    
    /// Returns a copy of this image scaled by `scaleFactor`.
    /// - important: `scaleFactor` must be greater than zero.
    func scaledBy(_ scaleFactor: Double) -> UIImage {
        
        guard scaleFactor > 0
        else { fatalError("scaleFactore must be > 0") /*EXIT*/ }
        
        let newSize = size.scaledBy(scaleFactor)
        
        return resizeTo(newSize) /*EXIT*/
        
    }
    
    // source: https://stackoverflow.com/questions/31314412/how-to-resize-image-in-swift
    func resizeTo(_ targetSize: CGSize) -> UIImage {
        
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
        
      }
    
}

// MARK: - Filters
//For more on filters see: https://spin.atomicobject.com/2016/10/20/ios-image-filters-in-swift/
public extension UIImage {
    
    /// Returns a "ghosted" or slightly brighter fully desaturated version of the `UIImage`
    /// - important: this method is not performant, use cautiously.
    var ghost: UIImage {
        
        let ciImage = CIImage(image: self)!
        
        return UIImage(ciImage: ciImage.applyingFilter("CIColorControls",
                                                       parameters: ["inputSaturation": 0,
                                                                    "inputContrast": 1.0,
                                                                    "inputBrightness": 0.3]))
        
    }
    
    /// Returns a half-tone/saturated version of `self`
    /// - parameter usingWidth: width of hafltone dot
    /// - parameter withSaturation: specifies a saturation, 1 is normal > 1 is supersaturated, < 1 is unsaturated
    /// - important: this method is non-performant, use cautiously, do not set saturation if using a value of 1.
    /// - note: 20 is a good starting value for `usingWidth`.
    func halftone(usingWidth width: Double = 20,
                  withSaturation saturation: Double? = nil) -> UIImage {
        
        let baseImg = CIImage(image: self)!
        let final: CIImage!
        
        assert(saturation != 1.0, """
                                    Do not specify saturation of 1.0, that is \
                                    the default. Setting to 1.0 results in a \
                                    lot of needless processing
                                    """)
        
        if let saturation = saturation {
            
            final =  baseImg.applyingFilter("CIColorControls",
                                            parameters: ["inputSaturation": saturation,
                                                         "inputContrast": 1.0,
                                                         "inputBrightness": 0.1]).applyingFilter("CICMYKHalftone",
                                                                                                 parameters: [kCIInputWidthKey: width] )
            
        } else {
            
            final = baseImg.applyingFilter("CICMYKHalftone",
                                           parameters: [kCIInputWidthKey: width] )
            
        }
        
        return UIImage(ciImage: final)
        
    }
    
    /// Fixes improper orientation of UIImage.
    /// - note: Useful for fixing images taken with camera.
    func fixOrientation() -> UIImage {
        
        if (self.imageOrientation == .up) { return self /*EXIT*/ }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let rect = CGRect(x: 0,
                          y: 0,
                          width: self.size.width,
                          height: self.size.height)
        
        self.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return normalizedImage
        
    }

    /// Creates a UIImage of solid `color` having frame `withFrame`
    static func solid(_ color: UIColor, withFrame frame: CGRect) -> UIImage {
        
        /// Creates a CIImage of solid color but *infinite size*
        let ciImage = CIImage(color: CIColor(color: color))
        
        /// Create CGImage in order to specify the size of the image.
        let cgImage = CIContext().createCGImage(ciImage, from: frame)
                
        return  UIImage(cgImage: cgImage!)
        
        
    }
    
}
