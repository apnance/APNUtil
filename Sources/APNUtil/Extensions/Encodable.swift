//
//  Encodable.swift
//  APNUtil
//
//  Created by Aaron Nance on 8/7/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import Foundation

public extension Encodable {
    
    func toJSONData() -> Data {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try! encoder.encode(self)

        return data /*EXIT*/
        
    }
    
}
