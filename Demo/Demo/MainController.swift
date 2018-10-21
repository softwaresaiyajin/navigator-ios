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
    static let root = ["/root"]
    static let detail = ["/screenTwo"]
    static let openUrl = ["/openUrl"]
    
}

class MainController {
    
    private(set) var window: UIWindow!
    
    @discardableResult
    static func launch(window: UIWindow) -> MainController {
        let controller = MainController()
        controller.setup(window: window)
        return controller
    }
    
    fileprivate func setup(window: UIWindow) {
        self.window = window
        setupRouteMapping()
        Navigator.shared.navigate(id: Route.root.first)
    }
    
    fileprivate func setupRouteMapping() {
        
        Navigator.shared
            .map(ids: Route.root, location: ViewController.self) { [weak self] (event) in
                
                event.destination.title = "Master"
                let navigation = UINavigationController(rootViewController: event.destination)
                self?.window.rootViewController = navigation
            
            }.map(ids: Route.detail, location: TestViewController.self) { [weak self] (event) in
                
                guard let navcon = self?.window.rootViewController as? UINavigationController else { return }
                event.destination.title = "Detail"
                navcon.pushViewController(event.destination, animated: true)
                
            }.map(ids: Route.openUrl, location: CustomLocation(value: URL(string: "https://www.google.com"))) {
                (event) in
                
                guard let url = event.destination.value else { return }
                UIApplication.shared.open(url,
                                          options: [:],
                                          completionHandler: nil)
        }
    }
}
