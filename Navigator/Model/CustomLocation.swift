//
//  CustomLocation.swift
//  Navigator
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public class CustomLocation<T>: NSObject {
    
    public private(set) var value: T?
    
    public init(value: T?) {
        self.value = value
        super.init()
    }
}
