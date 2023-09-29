//
//  Utils.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/25/15.
//  Copyright © 2015 Nance. All rights reserved.
//

import AVFoundation
import UIKit

// MARK: - Class
public class Utils {
    
    public static var shouldLog = true {
        didSet { NSLog("Logging Supressed : Set Utils.shouldLog true to re-enable NSLogging statements") }
    }
    
    public static func log(_ msg: String) {
        
        if shouldLog { NSLog(msg) }
        
    }
    
    // MARK: - Thread
    /// Aynchronously runs `updates` on main thread.
    public static func performUIUpdatesOnMain(updates: @escaping () -> ()) {
        
        DispatchQueue.main.async { updates() }
        
    }
    
    /// Asynchronously runs closure on main thread after specified `delay`.
    public func delay(_ delay: Double, closure: @escaping () -> ()) {
        
        let deadline = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: closure)
        
    }
    
    
    // MARK: - Sound
    public static var player: AVAudioPlayer?
    @available(iOS 11.0, *)
    public static func playSoundNOTWORKING(soundName name: String, type: String) {
        
        guard let url = Bundle.main.url(forResource: name, withExtension: type)
        else { return /*EXIT*/ }
        
        do {
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
            try AVAudioSession.sharedInstance().setActive(true)
            
            if player?.isPlaying ?? false {
                
                player?.stop()
                
            }
            
            // The following line is required for the player to work on iOS 11.
            // Change the file type accordingly
            var fileTypeHint: AVFileType!
            
            switch type {
                
                case "wav": fileTypeHint = AVFileType.wav
                
                case "mp3": fileTypeHint = AVFileType.mp3
                
                default: fileTypeHint = AVFileType.mp3
                
            }
            player = try AVAudioPlayer(contentsOf: url,
                                       fileTypeHint: fileTypeHint.rawValue)
            
            player?.prepareToPlay()
            
            // iOS 10 and earlier require the following line:
            // player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
            
            guard let player = player
            else { return /*EXIT*/ }
            
            player.play()
            
        } catch let error { print(error.localizedDescription) /*EXIT*/ }
        
    }
    
    
    // MARK: - Cocoa
    /// Return the top-most displayed UIViewController.
    /// Returns the app rootViewController if there are no presented
    /// view controllers.
    public static var topViewController: UIViewController? {
        
        guard
            UIApplication.shared.windows.count != 0,
            var tvc = UIApplication.shared.windows[0].rootViewController
        else { fatalError() /*EXIT*/ }
        
        while let presentedViewController = tvc.presentedViewController {
            
            tvc = presentedViewController
            
        }
        
        return tvc
        
    }
    
    // MARK: - plist
    public static func readPropertyList(listName: String) -> [String: AnyObject] {

        var propertyListForamt =  PropertyListSerialization.PropertyListFormat.xml
        var plistData: [String: AnyObject] = [:]
        let plistPath: String? = Bundle.main.path(forResource: listName, ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        
        do {
            
            // Convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML,
                                                                   options: .mutableContainersAndLeaves,
                                                                   format: &propertyListForamt) as! [String:AnyObject]
            
        } catch {
            
            print("Error reading plist: \(error), format: \(propertyListForamt)")
            
        }
        
        return plistData
        
    }
    
    public static func registerDefaultsFromSettingsBundle() {
        
        let settingsUrl = Bundle.main.url(forResource: "Settings",
                                          withExtension: "bundle")!.appendingPathComponent("Root.plist")
        let settingsPlist = NSDictionary(contentsOf:settingsUrl)!
        let preferences = settingsPlist["PreferenceSpecifiers"] as! [NSDictionary]
        
        var defaultsToRegister = Dictionary<String, Any>()
        
        for preference in preferences {
            
            guard let key = preference["Key"] as? String
            else { continue /*CONTINUE*/ }
            
            defaultsToRegister[key] = preference["DefaultValue"]
            
        }
        
        UserDefaults.standard.register(defaults: defaultsToRegister)
        
    }
    
    // MARK: - Views
    public static func rotate(view: UIView,
                              angle: Double) {
        
        let radians = CGFloat(angle * Double.pi/180.0)
        view.transform = CGAffineTransform(rotationAngle: radians)
        
    }
    
    public static func rotate(view: UIView,
                              rotateFunction: () -> Double) {
        
        let angle = rotateFunction()
        rotate(view: view, angle: angle)
        
    }
    
    public static func rotateRandom(view: UIView,
                                    minRotation min: Double,
                                    maxRotation max: Double) {
        
        rotate(view: view, angle: Double.random(min: min, max: max))
        
    }
    
    public static func rotateRandom(view: UIView,
                                    minAngle: Double,
                                    maxAngle: Double) {
        
        let angle = Double.random(min: minAngle, max: maxAngle)
        
        let degrees = CGFloat(angle * Double.pi/180.0)
        view.transform = CGAffineTransform(rotationAngle: degrees)
        
    }
    
    public static func translateRandom(view: UIView,
                                minX x1: Double = 0,
                                maxX x2: Double = 0,
                                minY y1: Double = 0,
                                maxY y2: Double = 0) {
        
        translate(view: view,
                  x: Double.random(min: x1, max: x2),
                  y: Double.random(min: y1, max: y2))
        
    }
    
    public static func scale(view: UIView, x: Double, y: Double) {
        
        view.transform = view.transform.scaledBy(x: CGFloat(x), y: CGFloat(y))
        
    }
    
    public static func flipX(view: UIView) { scale(view: view, x: -1, y: 1) }
    public static func flipY(view: UIView) { scale(view: view, x: 1, y: -1) }
    
    public static func translate(view: UIView, x: Double, y: Double) {
        
        view.transform = view.transform.translatedBy(x: CGFloat(x),
                                                     y: CGFloat(y))
        
    }
    
    public static func setToIdentity(view: UIView) {
        
         view.transform = CGAffineTransform.identity
        
    }
    
    
    // MARK: - Dates
    public static let dateFormatLongTemplate   = "EEE M/dd/yy, h:mm:ssa"
    public static let dateFormatMediumTemplate = "EEE MMM dd h:mma'"
    public static let dateFormatShortTemplate  = "MM/dd, h:mma'"
    
    public static func getDateString(format: String = Utils.dateFormatLongTemplate) -> String {
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date as Date)
        
    }
    
    
    // MARK: - Fonts
    public static func setFontWithStroke(control:UIView?,
                                         fontSize: CGFloat,
                                         fontName: String,
                                         fontColor: UIColor,
                                         strokeColor: UIColor = UIColor.black,
                                         strokeWidth: CGFloat = -2.0,
                                         alignment: NSTextAlignment = .center) {
        
        if control == nil { return /*EXIT*/ }

        let textAtts = [NSAttributedString.Key.font: UIFont(name: fontName,
                                                            size: fontSize)!,
                        NSAttributedString.Key.foregroundColor: fontColor,
                        NSAttributedString.Key.strokeColor: strokeColor,
                        NSAttributedString.Key.strokeWidth: strokeWidth ] as [NSAttributedString.Key : Any]
        
        switch control {

            case is UITextField:
                
                let tf = control as! UITextField
                
                let converted = Dictionary(uniqueKeysWithValues: textAtts.map{key, value in (key.rawValue, value) })
                
                tf.defaultTextAttributes = convertToNSAttributedStringKeyDictionary(converted)
                
                tf.textAlignment = alignment
            
            case is UILabel:
                
                let lbl = control as! UILabel
                lbl.attributedText  = NSAttributedString(string: lbl.text!,
                                                        attributes: textAtts)
                lbl.textAlignment   = alignment
            
            default: print("Ooops, unhandled control type")
            
        }
        
    }
    
    // Prints a list of all available fonts, resulting strings are usable by
    // UIFont class.
    public static func listAvailableFonts() {
        
        let familyNames = UIFont.familyNames
        
        for familyName in familyNames {
            
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            
            // PRINT
            for font in fontNames { print(font) }
            
        }
        
    }
    
    // MARK: - Images
    public static func getNSURLUserFilePathForFileName(fileName: String) -> NSURL? {
        
            //BUILD file path and READY session
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                              .userDomainMask,
                                                              true)[0] as String
        
            let pathArray = [dirPath, fileName]
            
            return NSURL.fileURL(withPathComponents: pathArray) as NSURL?
        
    }
    
    public static func getImageFromMainBundle(imageNameAndExtension: String) -> UIImage {
        
        if let image = UIImage(named: imageNameAndExtension,
                               in: Bundle.main, compatibleWith: nil) {
            
            return image /*EXIT*/
            
        } else {
            
            // RETURN empty image if no image found
            return UIImage()
            
        }
        
    }
    
    public static func writeImageToCameraRoll(image: UIImage) {
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
    }
    
    public static func saveImage(image: UIImage) {
        
        if let image = UIImage(named: "example.png") {
            if let data = image.pngData() {
                let filePath = getDocumentsDirectory().appendingPathComponent("copy.png")
                
                let url = URL(fileURLWithPath: filePath)
                
                do { try data.write(to: url) }
                catch { print(error) }
                
            }
            
        }
        
    }
    
    public static func getDocumentsDirectory() -> NSString {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask,
                                                        true)
        
        let documentsDirectory = paths[0]
        
        return documentsDirectory as NSString
        
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    
    return input.rawValue
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
    
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    
}
