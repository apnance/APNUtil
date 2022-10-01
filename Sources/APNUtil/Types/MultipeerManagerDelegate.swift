//
//  MultipeerManagerDelegate.swift
//  APNUtil
//
//  Created by Aaron Nance on 4/18/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import MultipeerConnectivity

public protocol MultipeerManagerDelegate: AnyObject {
    
    /// Called when a device connects to a peer(either as host or guest).
    func didConnect(_ state: MCSessionState, session: MCSession)
    
    /// Called when a peer disconnects.
    func didDisconnect(_ state: MCSessionState, session: MCSession)
    
    /// Called when a manager receives data from a peer via send request.
    func didReceiveData(_ data: Data, session: MCSession)
    
    /// Called right before a host device receives a confirmation alert.
    func willPresentInvitation(_ advertiserAssistant: MCAdvertiserAssistant)
    
    /// Called upon dismissal of confirmation alert on host device.
    /// - important: this is called regardless of whether or not the host device accepts the guest's invitation.
    func didDismissInvitation(_ advertiserAssistant: MCAdvertiserAssistant)
    
    /// Called when manager starts advertising itself as a host.
    func didInitiateHostSession(_ session: MCSession)
    
    /// Called when manager stop advertising itself as a host and disconnects
    func didTerminateHostSession(_ session: MCSession)

    /// Called when non-host peer joins a session.
    /// Note: host calls host calls didInitiateHostSession(:) instead
    func didJoinSession(_ session: MCSession)
    
    /// Called when non-host peer joins a session.
    /// Note: host calls didTerminate(:) instead
    func didLeaveSession(_ session: MCSession)
    
}
