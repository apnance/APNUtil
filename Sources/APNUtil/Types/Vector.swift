//
//  Vector.swift
//
//  Created by Aaron Nance on 6/22/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import Foundation

public typealias  Vector = (x: Double, y:Double, z: Double)

public struct VectorMath {
    
    /// Takes two Vectors compares them and returns a new Vector comprised of the greater value for each
    /// dimension.
    public static func maxes(vector1: Vector, vector2: Vector) -> Vector {
        
        return (max(vector1.x, vector2.x),
                max(vector1.y, vector2.y),
                max(vector1.z, vector2.z))
        
    }
    
    public static func absRounded(_ v: Vector) -> Vector {
        
        return (abs(round(v.x)),
                abs(round(v.y)),
                abs(round(v.z)))
        
    }
    
    public static func multiply(_ v: Vector, times coeff: Double) -> Vector {
        
        return (v.x * coeff, v.y * coeff, v.z * coeff)
        
    }
    
    public static func divide(_ v: Vector, times coeff: Double) -> Vector {
        
        return (v.x / coeff, v.y / coeff, v.z / coeff)
        
    }
    
    public static func anyDimensionsOf(_ v1: Vector,
                                       greaterThanAnyOf v2: Vector) -> Bool {
        
        return v1.x > v2.x || v1.y > v2.y || v1.z > v2.z
        
    }
    
}
