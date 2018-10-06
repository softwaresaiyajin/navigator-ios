//
//  Navigator.swift
//  Navigator
//
//  Created by Gerald Adorza on 29/9/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public class Navigator {
    
    public typealias PathNotFoundObserver = (String, Any?) -> Void
    
    private var onPathNotFound: PathNotFoundObserver?
    
    public static let shared = Navigator()
    
    private var events: [String: IEvent] = [:]

    public var mappedLocations: [String] {
        return events.map( { "\($0.key) => \($0.value.detail ?? "")" })
    }
    
    @discardableResult
    public func mapPathNotFound(observer: PathNotFoundObserver?) -> Self {
        onPathNotFound = observer
        return self
    }
    
    @discardableResult
    public func map<T>(ids: [String],
                       location: NavigationEvent<T>.LocationOption,
                       observer: NavigationEvent<T>.NavigationObserver?) -> Self {
        
        let event = NavigationEvent(location: location, observer: observer)
        ids.forEach { (id) in
            events[id] = event
        }
        return self
    }
    
    public func navigate(id: String, data: Any? = nil) {
        
        let location = events[id]
        let isValid = location?.notifyObserver(data: data) ?? false
        if !isValid {
            onPathNotFound?(id, data)
        }
    }
}












