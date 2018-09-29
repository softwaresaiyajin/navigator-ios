//
//  MainController.swift
//  Demo
//
//  Created by Gerald Adorza on 29/9/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import UIKit
import Navigator

struct Route {
    
    static let dismiss = ["/"]
    static let root: [IPathIdentifier] = ["/root"]
    static let screenOne: [IPathIdentifier] = ["/screenOne"]
    static let screenTwo = ["/screenTwo"]
    
}

extension String: IPathIdentifier {
    public var stringIdentifier: String { return self }
}

extension ViewController: IViewController {
    
    static func create() -> UIViewController {
        return ViewController()
    }
}

extension TestViewController: IViewController {
    
    static func create() -> UIViewController {
        return TestViewController()
    }
}


class MainController {
    
    private(set) var window: UIWindow!
    
    static func launch(window: UIWindow) {
        let controller = MainController()
        controller.setup(window: window)
    }
    
    fileprivate func setup(window: UIWindow) {
        self.window = window
        setupRouteMapping()
        
        Navigator.shared.navigate(id: Route.root.first ?? "")
    }
    
    fileprivate func setupRouteMapping() {
        
        let manager = Navigator.shared
        
        manager
            .map(ids: Route.root,
                 location: .type(ViewController.self)) { [weak self] (event) in
                
                    let navigation = UINavigationController(rootViewController: event.controller)
                    self?.window.rootViewController = navigation
            }
            .map(ids: Route.screenOne,
                  location: .type(TestViewController.self)) { (event) in
                
        }
        
        manager
            .mapPathNotFound(observer: { (_, _) in
            
            })
        
    }
    
}
