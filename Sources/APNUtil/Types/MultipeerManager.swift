//
//  MultipeerManager.swift
//  APNUtil
//
//  Created by Aaron Nance on 4/18/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation
import MultipeerConnectivity

public enum MultipeerConnectionState: Int {
    
    case unconnected
    case connectedGuest
    case connectedHosting
    case unconnectedHosting
    
}

/// - important: MultipeerManager requires the removal of SceneDelegate. Revert AppDelegate and
/// Info.plist to pre- iOS 13 mechanism:
///
///         1. Remove manifest key from info.plist
///         2. Add `var window = UIWindow?` property to AppDelegate.
///
public class MultipeerManager: NSObject {
    
    // MARK: - Properties
    let containingVC: UIViewController!
    private weak var delegate: MultipeerManagerDelegate?
    public private(set) var serviceType = "mpm-gen"
    
    private let maxPeers: Int!
    private let peerID: MCPeerID!
    private let session: MCSession!
    private var adAssistant:MCAdvertiserAssistant!
    public private(set) var isHost = false
    
    public var connectionState: MultipeerConnectionState {
        
        if isHost {
            
            return hasConnectedPeers ? .connectedHosting : .unconnectedHosting
            
        } else {
            
            return hasConnectedPeers ? .connectedGuest : .unconnected
            
        }
        
    }
    
    /// Returns a `Bool` indicating if there are connected peers.
    public var hasConnectedPeers: Bool { session.connectedPeers.count > 0 }
    
    /// Returns the number of peers currently connected.
    public var connectedPeerCount: Int { return session.connectedPeers.count }
    
    /// Returns a `String` of comma separated peer names.
    public var peerNames: String {
        
        session.connectedPeers.reduce("") { ($0.isEmpty ? "" : "\($0), ") + $1.displayName }
        
    }
    
    /// - parameter withContainingViewConroller: the UIViewController that will be used for presenting connection `ActionSheet`
    /// - parameter delegate: `MultipeerManagerDelegate`
    public init(withContainingViewController containingVC: UIViewController,
                serviceType: String? = nil,
                delegate: MultipeerManagerDelegate,
                withMaxPeers maxPeers: Int) {
        
        
        self.containingVC = containingVC
        self.delegate = delegate
        self.maxPeers = maxPeers
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        
        super.init()
        
        session.delegate = self
        self.serviceType = serviceType ?? self.serviceType
        
    }
    
    
    // MARK: - Custom Methods
    /// Attempts to send the provided  `Data` to all connected peers.
    public func sendToPeers(_ data: Data) {
        
        if !hasConnectedPeers { return /*EXIT*/ }
        
        do {
            
            try session.send(data,
                             toPeers: session.connectedPeers,
                             with: .reliable)
            
            
        } catch {
            
            fatalError("Implement")
            
        }
        
    }
    
    public func connect(withInfo info: [String:String]? = nil) {
        
        let actionSheet = UIAlertController(title: "Connect to Another Device?",
                                            message: "Would you like to Host or Join a session?",
                                            preferredStyle: .actionSheet)
    
        if isHost {
            
            actionSheet.title = "Stop Hosting?"
            actionSheet.message = "Would you like stop hosting session?"
            
            actionSheet.addAction(UIAlertAction(title: "Stop Hosting",
                                                style: .default,
                                                handler: { (action:UIAlertAction) in
                                                    
                                                    self.disconnect()
                                                    
            }))
            
        } else if hasConnectedPeers {
            
            actionSheet.title = "Leave Session?"
            actionSheet.message = "Would you like to Leave the current session?"
            
            actionSheet.addAction(UIAlertAction(title: "Leave Session",
                                                style: .default,
                                                handler: { (action:UIAlertAction) in
                                                    
                                                    self.disconnect()
                                                    
            }))
            
        } else {
            
            actionSheet.addAction(UIAlertAction(title: "Host Session",
                                                style: .default,
                                                handler: {
                                                    
                                                    (action:UIAlertAction) in
                                                    
                                                    self.adAssistant = MCAdvertiserAssistant(serviceType: self.serviceType,
                                                                                             discoveryInfo: info,
                                                                                             session: self.session)
                                                    
                                                    self.isHost = true
                                                    
                                                    self.adAssistant.delegate = self
                                                    self.adAssistant.start()
                                                    
                                                    self.delegate?.didInitiateHostSession(self.session)
                                                    
            }))
        
            if !isHost {
                
                actionSheet.addAction(UIAlertAction(title: "Join Session",
                                                    style: .default,
                                                    handler: { (action:UIAlertAction) in
                                                        
                                                        let browser = MCBrowserViewController(serviceType: self.serviceType,
                                                                                              session: self.session)
                                                        
                                                        browser.delegate = self
                                                        browser.maximumNumberOfPeers = self.maxPeers
                                                        
                                                        self.containingVC.present(browser, animated: true, completion: nil)
                                                        
                                                        self.delegate?.didJoinSession(self.session)

                }))
                
            }
            
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        containingVC.present(actionSheet, animated: true, completion: nil)
        
    }
    
    public func disconnect() {
        
        session.disconnect()
        adAssistant?.stop()
        
        if isHost {
        
            isHost = false
            delegate?.didTerminateHostSession(session)
            
        } else {
            
            delegate?.didLeaveSession(session)
            
        }
        
    }
    
}

extension MultipeerManager: MCSessionDelegate {

    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
        // Echo
        let peerNames = session.connectedPeers.reduce("") { ($0.isEmpty ? "" : "\($0), ") + $1.displayName }
        print("Device: \(peerID.displayName)\t\tState: \(state)\t\tPeers:\(peerNames)")
        
        switch state {
            
        case MCSessionState.connected:
            
            if session.connectedPeers.count == maxPeers { adAssistant?.stop() }
            
            delegate?.didConnect(state, session: session)
            
            DispatchQueue.main.async { self.containingVC.presentedViewController?.dismiss(animated: true, completion: nil) }
            
        case MCSessionState.connecting: break /*EXIT*/
            
        case MCSessionState.notConnected:
            
            if isHost && session.connectedPeers.count < maxPeers {
                
                adAssistant?.start()
                
            }
            
            delegate?.didDisconnect(state, session: session)
            
        default: fatalError("\(#function) Unhandled case: \(state)")
            
        }
        
    }
    
    public func session(_ session: MCSession,
                 didReceive data: Data,
                 fromPeer peerID: MCPeerID) {
        
        delegate?.didReceiveData(data, session: session)
        
    }
    
    /* Required But Unused Protocol Methods */
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) { /*Unused*/ }
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) { /*Unused*/ }
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) { /*Unused*/ }
    
}

// MARK: - MCBrowserViewControllerDelegate
extension MultipeerManager: MCBrowserViewControllerDelegate {
    
    public func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        
        DispatchQueue.main.async {
            self.containingVC.presentedViewController?.dismiss(animated: true, completion: nil)
        }
        
    }
    
    public func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        
        DispatchQueue.main.async {
            self.containingVC.presentedViewController?.dismiss(animated: true, completion: nil)
        }
        
    }
    
}

// MARK: - MCAdvertiserAssistantDelegate
extension MultipeerManager: MCAdvertiserAssistantDelegate {
    
    public func advertiserAssistantWillPresentInvitation(_ advertiserAssistant: MCAdvertiserAssistant) {
        
        delegate?.willPresentInvitation(advertiserAssistant)
        
    }
    
    public func advertiserAssistantDidDismissInvitation(_ advertiserAssistant: MCAdvertiserAssistant) {
        
        delegate?.didDismissInvitation(advertiserAssistant)
        
    }
    
}

extension MCSessionState: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
            
            case MCSessionState.connected:      return "Connected"
            case MCSessionState.connecting:     return "Connecting"
            case MCSessionState.notConnected:   return "Disconnected"
            
            default: fatalError("\(#function) - Unhandled case: \(self)")
            
        }
        
    }
    
}
