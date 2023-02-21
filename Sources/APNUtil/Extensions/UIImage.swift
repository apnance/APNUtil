//
//  UIImage.swift
//  APNUtil
//
//  Created by Aaron Nance on 4/23/18.
//  Copyright © 2018 Nance. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /// Attempts to initialize a `UIImage` looking for the image in the specified subPath of the document directory.
    convenience init?(withSubPath: String) {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = FileManager.cleanFilePath("\(paths[0])/\(withSubPath)")
        
        self.init(contentsOfFile: path)
        
    }
    
    /// Attempts to initialize a `UIImage`  with the given `width` and `height` using the provided `PixelData` array for pixel colors.
    convenience init?(pixels: [PixelData], width: Int, height: Int) {
        
        guard width > 0 && height > 0, pixels.count == width * height else { fatalError() /*EXIT*/ }
        
        var data = pixels
        
        guard let providerRef = CGDataProvider(data: Data(bytes: &data,
                                                          count: data.count * MemoryLayout<PixelData>.size) as CFData)
        else { fatalError() /*EXIT*/ }
        
        guard let cgim = CGImage(width: width,
                                 height: height,
                                 bitsPerComponent: 8,
                                 bitsPerPixel: 32,
                                 bytesPerRow: width * MemoryLayout<PixelData>.size,
                                 space: CGColorSpaceCreateDeviceRGB(),
                                 bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue),
                                 provider: providerRef,
                                 decode: nil,
                                 shouldInterpolate: false,
                                 intent: .defaultIntent)
        else { fatalError() /*EXIT*/ }
        
        self.init(cgImage: cgim)
        
    }
    
    /// Attempts to write the contents of the `UIImage` to the specified namd and sub directory of the couments directory.
    /// - returns: a boolean indicating success of the write attempt.
    func writeToFile(fileName: String, subDir: String) -> Bool {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        // Save image.
        do {
            
            try FileManager.createSubDir(subDir)
            
            let filePath    = FileManager.cleanFilePath("\(paths[0])/\(subDir)\(fileName)")
            let fileURL     = URL(fileURLWithPath: filePath)
            
            try pngData()?.write(to: fileURL,
                                 options: .atomic)
            
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
    
    /// Creates a `UIImage` of solid `color` having frame `withFrame`
    static func solid(_ color: UIColor, withFrame frame: CGRect) -> UIImage {
        
        // Creates a CIImage of solid color but *infinite size*
        let ciImage = CIImage(color: CIColor(color: color))
        
        // Create CGImage in order to specify the size of the image.
        let cgImage = CIContext().createCGImage(ciImage, from: frame)
        
        return  UIImage(cgImage: cgImage!)
        
    }
    
}

// MARK: - Effects
public extension UIImage {
    
    
    /// Converts UIImage into a simulated LCD screen effect.
    ///
    /// Renders a UIImage in a magnified LCD screen effect.  The effect is achieved
    /// by converting each pixel in a 4x4 representation of that pixel, with top and left
    /// clear "seam" between "lcd pixels." The effect is achieved by converting each
    /// pixel from the source UIImage into a 4x4 series of new pixels with  a top row of
    /// transparent pixels, a left column of transparent/clear pixels(C) and then a
    /// 3-pixel wide row of the red component value, a 3 pixel row of green component
    /// value(G), and a three pixel row of blue component value.
    ///
    /// ````
    /// Each pixel in the image is converted to the this format:
    ///
    ///                         C C C C
    ///                         C R R R
    ///                         C G G G
    ///                         C B B B
    ///
    /// C = clear/transperent, R = Red, G = Green value, B = Blue value
    ///
    /// For example, a red pixel with ARGB value (A: 255, R: 220, G: 0, B: 0) would be converted to:
    ///
    ///  Original Pixel                       Converted 4x4 "LCD Pixel"
    /// -------------------------------------------------------------------------------
    ///                         (0,0,0,0)  (0,0,0,0)      (0,0,0,0)      (0,0,0,0)
    ///  (255,220,0,0)     ->   (0,0,0,0)  (255,220,0,0)  (255,220,0,0)  (255,220,0,0)
    ///                         (0,0,0,0)  (0,0,0,0)      (0,0,0,0)      (0,0,0,0)
    ///                         (0,0,0,0)  (0,0,0,0)      (0,0,0,0)      (0,0,0,0)
    ///
    /// ````
    func pixelatedLCD() -> UIImage? {
        
        let height      = Int(self.size.height)
        let width       = Int(self.size.width)
        let newHeight   = height * 4
        let newWidth    = width  * 4
        
        guard let originalPixels = pixelData() // Unaltered image
        else { return nil /*FAILED*/ }
        
        let clearPixelData = PixelData(a: 0, r: 0, g: 0, b: 0)
        var newPixels = Array<PixelData>(repeating: clearPixelData, // defaults are clear/transparent
                                         count: newHeight * newWidth)
        
        for row in 0..<height {
            
            for col in 0..<width {
                
                let pixelLoc        = (row * width * 4) + (col * 4)
                var newPixelIndex   = (row * newWidth * 4) + (col * 4)
                
                // Avoid array overflow by skipping last few lines.
                if (newPixelIndex + (3 * newWidth)) > newPixels.lastUsableIndex { continue /*CONTINUE*/ }
                
                let alpha   = originalPixels[pixelLoc]
                let red     = PixelData(a: alpha, r: originalPixels[pixelLoc + 1], g: 0, b: 0)
                let green   = PixelData(a: alpha, r: 0, g: originalPixels[pixelLoc + 2], b: 0)
                let blue    = PixelData(a: alpha, r: 0, g: 0, b: originalPixels[pixelLoc + 3])
                
                // Top Clear
                // first row all columns are clear - use default(clear) values
                
                // Red Pixel
                newPixelIndex += newWidth // Next Row
                // first column is clear - use default
                newPixels[newPixelIndex + 1 ] = red
                newPixels[newPixelIndex + 2 ] = red
                newPixels[newPixelIndex + 3 ] = red
                
                // Green Pixel
                newPixelIndex += newWidth // Next Row
                // first column is clear - use default
                newPixels[newPixelIndex + 1 ] = green
                newPixels[newPixelIndex + 2 ] = green
                newPixels[newPixelIndex + 3 ] = green
                
                // Blue Pixel
                newPixelIndex += newWidth // Next Row
                
                // first column is clear - use default
                newPixels[newPixelIndex + 1 ] = blue
                newPixels[newPixelIndex + 2 ] = blue
                newPixels[newPixelIndex + 3 ] = blue
                
            }
            
        }
        
        return UIImage(pixels: newPixels, width: newWidth, height: newHeight)
        
    }
    
    // - MARK: PixelData
    // Source:
    // https://www.itcodar.com/ios/pixel-array-to-uiimage-in-swift.html#:~:text=Generate%20Image%20from%20Pixel%20Array%20%28fast%29%20The%20most,pixel%20data%20as%20array%20from%20UIImage%2FCGImage%20in%20swift
    
    /// 32-bit  pixel component values.
    struct PixelData: CustomStringConvertible {
        
        var a: UInt8
        var r: UInt8
        var g: UInt8
        var b: UInt8
        
        /// Note: Alpha compent defaults to opaque(255) if unspecified.
        init(a: UInt8 = 255, r: UInt8, g: UInt8, b: UInt8) {
            
            self.a = a
            self.r = r
            self.g = g
            self.b = b
            
        }
        
        public var description: String { "A:\(a) R:\(r) G:\(g) B:\(b)"}
        
    }
    
    /// Returns the 8-bit pixel information of `self` as an array of `size.width * size.height` count.
    func pixelData() -> [UInt8]? {
        
        let size        = self.size
        let dataSize    = size.width * size.height * 4
        var pixelData   = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace  = CGColorSpaceCreateDeviceRGB()
        
        let context     = CGContext(data: &pixelData,           // Render data into pixelData array
                                    width: Int(size.width),
                                    height: Int(size.height),
                                    bitsPerComponent: 8,
                                    bytesPerRow: 4 * Int(size.width),
                                    space: colorSpace,
                                    bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        let cgImage     = self.cgImage!
        
        context?.draw(cgImage, in: CGRect(x: 0, y: 0,
                                          width: size.width, height: size.height))
        
        return pixelData
        
    }
    
}

// - MARK: Diagnostics
public extension UIImage {
    
    /// `UIImage` diagnostic function that prints out ARGB values of the pixels in `self`
    func printARGB() {
        
        guard let pixels = pixelData() // Unaltered image
        else { return /*FAILED*/ }
        
        let height      = Int(self.size.height)
        let width       = Int(self.size.width)
        
        for row in 0..<height {
            
            for col in 0..<width {
                
                let pixelLoc = (row * width * 4) + (col * 4)
                
                print("""
                A:\(pixels[pixelLoc]) \
                R:\(pixels[pixelLoc + 1]) \
                G:\(pixels[pixelLoc + 2]) \
                B:\(pixels[pixelLoc + 3])
                """)
                
            }
            
        }
        
    }
    
}
