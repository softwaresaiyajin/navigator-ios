//
//  Navigator.swift
//  Navigator
//
//  Created by Gerald Adorza on 29/9/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public protocol IPathIdentifier {
    var stringIdentifier: String { get }
}



public class Navigator {
    
    public typealias PathNotFoundObserver = (IPathIdentifier, Any?) -> Void
    
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
    public func map<T>(ids: [IPathIdentifier],
                       location: LocationOption<T>,
                       observer: NavigationEvent<T>.NavigationObserver?) -> Self {
        
        let event = NavigationEvent(location: location, observer: observer)
        ids.forEach { (id) in
            events[id.stringIdentifier] = event
        }
        return self
    }
    
    public func navigate(id: IPathIdentifier, data: Any? = nil) {
        
        guard let location = events[id.stringIdentifier],
            location.isValid else {
            onPathNotFound?(id, data)
            return
        }
        location.notifyObserver(data: data)
        
    }
}












