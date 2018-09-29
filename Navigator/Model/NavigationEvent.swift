//
//  Path.swift
//  Navigator
//
//  Created by Gerald Adorza on 29/9/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

protocol IEvent {
    
    var detail: Any? { get }
    
    var isValid: Bool { get }
    
    func notifyObserver(data: Any?)
}

public protocol IViewController {
    
    static func create() -> UIViewController
}


public class NavigationEvent<T: IViewController> {
 
    public typealias NavigationObserver = (T, Any?) -> Void
    
    private(set) var observer: NavigationObserver?
    
    private(set) var instance: T?
    
    private(set) var type: T.Type?
    
    private var value: T? {
        return instance ?? type?.create() as? T
    }
    
    init(instance: T, observer: NavigationObserver?) {
        self.instance = instance
        setObserver(observer)
    }
    
    init(type: T.Type, observer: NavigationObserver?) {
        self.type = type
        setObserver(observer)
    }
    
    fileprivate func setObserver(_ observer: NavigationObserver?) {
        self.observer = observer
    }
}

extension NavigationEvent: IEvent  {
    
    var detail: Any? {
        if let value = instance { return value }
        else if let value = type {  return "\(value).self" }
        return nil
    }
    
    var isValid: Bool { return value != nil }
    
    func notifyObserver(data: Any?) {
        observer?(value!, data)
    }
}

