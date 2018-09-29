//
//  Path.swift
//  Navigator
//
//  Created by Gerald Adorza on 29/9/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public enum LocationOption<T> {
    case instance(T)
    case type(T.Type)
}

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
    
    private(set) var location: LocationOption<T>?

    private var value: T? {
        guard let option = location else { return nil }
        switch option {
        case .instance(let value): return value
        case .type(let value): return value.create() as? T
        }
    }
    
    init(location: LocationOption<T>, observer: NavigationObserver?) {
        self.location = location
        self.observer = observer
    }
}

extension NavigationEvent: IEvent  {
    
    var detail: Any? {
        guard let option = location else { return nil }
        switch option {
        case .instance(let value): return value
        case .type(let value): return "\(value).self"
        }
    }
    
    var isValid: Bool { return value != nil }
    
    func notifyObserver(data: Any?) {
        observer?(value!, data)
    }
}

