//
//  UIViewController.swift
//  APNUtil
//
//  Created by Aaron Nance on 9/25/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation
import MessageUI

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
