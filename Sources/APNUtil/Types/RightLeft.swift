//
//  RightLeft.swift
//  APNUtil
//
//  Created by Aaron Nance on 8/3/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

public enum RightLeft {
    
    case right, left
    
    public var isLeft: Bool {   self == .left }
    public var isRight: Bool {  self == .right }
    
}
