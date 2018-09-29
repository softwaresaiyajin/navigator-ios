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
    
    public func mapPathNotFound(observer: PathNotFoundObserver?) {
        onPathNotFound = observer
    }
    
    public func map<T: IViewController>(ids: [IPathIdentifier],
                                        location: T,
                                        observer: NavigationEvent<T>.NavigationObserver?) {
        let event = NavigationEvent<T>(instance: location, observer: observer)
        ids.forEach { (id) in
            events[id.stringIdentifier] = event
        }
    }
    
    public func map<T: IViewController>(ids: [IPathIdentifier],
                                        location: T.Type,
                                        observer: NavigationEvent<T>.NavigationObserver?) {
        let event = NavigationEvent<T>(type: location, observer: observer)
        ids.forEach { (id) in
            events[id.stringIdentifier] = event
        }
    }
    
    public func navigate(id: IPathIdentifier, data: Any?) {
        
        guard let location = events[id.stringIdentifier],
            location.isValid else {
            onPathNotFound?(id, data)
            return
        }
        location.notifyObserver(data: data)
        
    }
}












