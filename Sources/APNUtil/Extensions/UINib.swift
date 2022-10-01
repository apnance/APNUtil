//
//  UINib.swift
//  Banker's Buddy
//
//  Created by Aaron Nance on 7/12/20.
//  Copyright © 2020 Aaron Nance. All rights reserved.
//

import UIKit

public extension UINib {
    
    /// Returns an instance of Any? from the named nib.
    static func instanceFromNib(_ name: String) -> Any? {
        
          let nib = UINib(nibName: name,
                          bundle: Bundle.main)
        
          return nib.instantiate(withOwner: nil, options: nil).first
        
      }
    
}
