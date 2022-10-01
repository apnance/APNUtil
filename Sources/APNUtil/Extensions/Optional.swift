//
//  Optional.swift
//  APNUtil
//
//  Created by Aaron Nance on 9/14/22.
//  Copyright © 2022 Aaron Nance. All rights reserved.
//

import Foundation

public extension Optional {
    
    var isNil : Bool { self == nil }
    var isNotNil: Bool { self != nil }
    
}
