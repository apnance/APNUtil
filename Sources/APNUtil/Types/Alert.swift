//
//  Alert.swift
//  APNUtil
//
//  Created by Aaron Nance on 4/2/16.
//  Copyright © 2016 Nance. All rights reserved.
//

import UIKit

public typealias AlertText = (title: String, message: String)

/// A wrapper class for easily creating Alerts of various types.
///
/// # Example #
/// ```swift
/// // Sample Use - Creates an alert with an 'OK' button with a callback fxn
///    let okHandler = { (action: UIAlertAction) -> () in self.showSettings(flag: 0) }
///
///    alert(title: "No Problems Loaded", message: "Add Some Problems In Settings",
///    buttonsDict: ["OK": okHandler], completion: nil )
/// ```
public struct Alert {
    
    // MARK: - Properties
    private static var alertController: UIAlertController?
    
    
    // MARK: - Custom Methods
    // getCurrentViewController: courtesy of jjv360:
    // http://stackoverflow.com/questions/24825123/get-the-current-view-controller-from-the-app-delegate?lq=1
    private static func getCurrentViewController(vc: UIViewController? = nil) -> UIViewController? {
        
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
    
    /// Convenience method that converts to ok(title:message)
    public static func ok(_ text: AlertText) {
        
        ok(title: text.title,
           message: text.message)
        
    }
    
    /// Creates a simple imformational alert with a single "Ok" button.
    public static func ok(title: String,
                          message: String) {
        
        alert(title:        title,
              message:      message,
              buttonsDict:  ["Ok": nil],
              completion:   nil)
        
    }
    
    /// Convenience method that converts to yesno(title:message:yesHandler:noHandler)
    public static func yesno(_ text: AlertText,
                             yesHandler: ((UIAlertAction)->())?,
                             noHandler: ((UIAlertAction)->())? = nil) {
        
        yesno(title: text.title,
              message: text.message,
              yesHandler: yesHandler,
              noHandler: noHandler)
        
    }
    
    /// Creates a simple alert posing yes/no question, handling each response appropriately.
    public static func yesno(title: String,
                             message: String,
                             yesHandler: ((UIAlertAction)->())?,
                             noHandler: ((UIAlertAction)->())?) {
        
                                alert(title: title,
                                      message: message,
                                      buttonsDict: ["Yes": yesHandler,
                                                    "No": noHandler],
                                      completion: nil) }
    
    public static func killCurrentAlert(completion: VoidHandler? = nil) {
        
        Utils.performUIUpdatesOnMain {
            
            alertController?.dismiss(animated: false, completion: completion)
            
            // alertControlller must be nillified or subsequent calls to alert
            // will short-circuit causing the alertController to not be presented again.
            alertController = nil
            
        }
        
    }
    
    // Convenience method that converts to alert(title:message:buttonDict:completion)
    public static func alert(_ text: AlertText,
                             buttonsDict: AlertButtonActionHandlerDictionary,
                             completion: (VoidHandler)! ) {
        
        alert(title: text.title,
              message: text.message,
              buttonsDict: buttonsDict,
              completion: completion)
        
    }
        
    public static func alert(title: String,
                             message: String,
                             buttonsDict: AlertButtonActionHandlerDictionary,
                             completion: (VoidHandler)! ) {

        if (alertController != nil) { return /*EXIT*/ }
        
        guard let presentingVC = getCurrentViewController()
        else { print("ALERT: Unable to get current view controller\nThis message could not be alerted:\(message)"); return /*EXIT*/ }
        
        alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        
        for (key, handler) in buttonsDict {
            
            let modifiedHandler: ((UIAlertAction)->())? = {
                                    action
                                    in
                                    handler?(action)
                                    alertController = nil
                                    }
            
            let style = key.lowercased() == "cancel" ? UIAlertAction.Style.cancel : UIAlertAction.Style.default
            
            alertController!.addAction(UIAlertAction(title: key,
                                                     style: style,
                                                     handler: modifiedHandler))
            
        }
        
        // Present Alert On Main Thread
        Utils.performUIUpdatesOnMain {
            
            presentingVC.present(alertController!,
                                 animated: true,
                                 completion: completion)
            
        }
        
    }
    
    public static func alertSimple(message: String) {
        
        alert(title: "Simple Debug Alert",
              message: message,
              buttonsDict: ["OK": nil],
              completion: nil)
        
    }
    
}
