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
    
    func notifyObserver(data: Any?) -> Bool
}

public protocol INavigatable {
    static func create() -> Any?
}

public class NavigationEvent<Destination: INavigatable> {
 
    public enum LocationOption {
        case instance(Destination)
        case type(Destination.Type)
    }
    
    public typealias NavigationObserver = (NavigationEvent<Destination>) -> Void
    
    private(set) var observer: NavigationObserver?
    
    private(set) var location: LocationOption?

    public private(set) var data: Any?
    
    public private(set) var destination: Destination!
    
    private var value: Destination? {
        guard let option = location else { return nil }
        switch option {
        case .instance(let value): return value
        case .type(let value): return value.create() as? Destination
        }
    }
    
    init(location: LocationOption, observer: NavigationObserver?) {
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
    
    func notifyObserver(data: Any?) -> Bool {
        guard let _value = value else { return false }
        destination = _value
        self.data = data
        observer?(self)
        return true
    }
}

