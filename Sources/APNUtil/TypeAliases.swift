//
//  TypeAliases.swift
//  APNUtil
//
//  Created by Aaron Nance on 4/7/16.
//  Copyright © 2016 Nance. All rights reserved.
//

import UIKit

public typealias VoidHandler = () -> ()
public typealias AlertButtonActionHandlerDictionary = [ String: ((UIAlertAction)->())? ]
public typealias BoolHandler = ((Bool) -> ())?
