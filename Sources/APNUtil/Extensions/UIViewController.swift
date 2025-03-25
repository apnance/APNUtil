//
//  UIViewController.swift
//  APNUtil
//
//  Created by Aaron Nance on 9/25/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation
import MessageUI

// - MARK: - Mail Composer
/// `Struct` encapsulating all required elements of a `MFMailComposeViewController` attachment data.
/// Used to pre-populate attachments argument of `UIViewController.emailComposer()`
public struct MailAttachment {
    
    let mimeType: String
    let data: Data
    let fileName: String
    
    public init(mimeType: String, data: Data, fileName: String) {
        
        self.mimeType = mimeType
        self.data = data
        self.fileName = fileName
        
    }
    
}

public extension UIViewController {
    
    /// Summons and presents a `MFMailComposeViewController` for compositing/sending of email.
    func emailComposer(to: [String]     = [],
                       subject: String  = "",
                       body: String     = "",
                       bodyIsHTML: Bool = false,
                       attachments: [MailAttachment] = [],
                       mailComposeDelegate: MFMailComposeViewControllerDelegate) {
        
        if MFMailComposeViewController.canSendMail() {
            
            let composer = MFMailComposeViewController()
            
            composer.mailComposeDelegate = mailComposeDelegate
            
            composer.setToRecipients(to)
            
            composer.setSubject(subject)
            
            composer.setMessageBody(body, isHTML: bodyIsHTML)
            
            for attachment in attachments {
            
                composer.addAttachmentData(attachment.data,
                                       mimeType: attachment.mimeType,
                                       fileName: attachment.fileName)
                
            }
            
            present(composer, animated: true)
            
        } else {
            
            Utils.log("MFMailComposeViewController cannot send mail.")
            
        }
        
    }
    
}

// - MARK: - General Utility
public extension UIViewController {
    
    // - MARK: Device Orientation (e.g Portrait, Landscape...)
    // Trigger Reveluation of Supported Interface Orientations(i.e. calling of supportedInterfaceOrientations)
    func triggerReevaluationOfSupportedInterfaceOrientations() {
        
        UIApplication.shared.delegate?.window??.rootViewController = nil
        UIApplication.shared.delegate?.window??.rootViewController = self
        
    }
        
    /// Triggers reporting of device orientation.
    /// - note: A useful starting point for handling device orienation changes
    func reportDeviceOrientationChanges() {
        
        // Notifications
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deviceDidRotate),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
        
    }
    
    @objc private func deviceDidRotate() {
        
        switch UIDevice.current.orientation {
                
            case .portrait:             print("Device rotated to Portrait")
                
            case .landscapeLeft:        print("Device rotated to Landscape Left")
                
            case .landscapeRight:       print("Device rotated to Landscape Right")
            
            case .portraitUpsideDown:   print("Device rotated to Portrait Upside Down")
            
            default:                    print("Unknown orientation")
                
        }
        
    }
    
}
