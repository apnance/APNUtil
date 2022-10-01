//
//  CMAcceleration.swift
//
//  Created by Aaron Nance on 6/22/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import CoreMotion

public extension CMAcceleration {
    
    var vector: Vector { return (x,y,z) }
    
    var vectorAbsRounded: Vector { return VectorMath.absRounded(vector) }
    
    var scaledRoundedAbsVector: Vector {
        
        var v = VectorMath.multiply(vector, times: 1000)
        
        v = VectorMath.absRounded(v)
        v = VectorMath.divide(v, times: 10)
        
        return v
        
    }
    
}
