//
//  Navigator.swift
//  Navigator
//
//  Created by Gerald Adorza on 29/9/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public class Navigator {
    
    public typealias PathNotFoundObserver = (String?, Any?) -> Void
    
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
                       location: T,
                       observer: NavigationEvent<T>.NavigationObserver?) -> Self {
        
        return map(ids: ids,
                   location: .instance(location),
                   observer: observer)
    }
    
    @discardableResult
    public func map<T>(ids: [String],
                       location: T.Type,
                       observer: NavigationEvent<T>.NavigationObserver?) -> Self {

        return map(ids: ids,
                   location: .type(location),
                   observer: observer)
    }
    
    fileprivate func map<T>(ids: [String],
                            location: NavigationEvent<T>.LocationOption,
                            observer: NavigationEvent<T>.NavigationObserver?) -> Self {
        let event = NavigationEvent(location: location, observer: observer)
        ids.forEach { (id) in
            events[id] = event
        }
        return self
    }
    
    public func navigate(id: String?, isAnimated: Bool = true, data: Any? = nil) {
        
        guard let identifier = id else {
            onPathNotFound?(id, data)
            return
        }
        
        let location = events[identifier]
        let isValid = location?.notifyObserver(data: data, isAnimated: isAnimated) ?? false
        if !isValid {
            onPathNotFound?(identifier, data)
        }
    }
}
