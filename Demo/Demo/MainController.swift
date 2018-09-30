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
    static let screenOne = ["/screenOne"]
    static let screenTwo = ["/screenTwo"]
    static let openUrl = ["/openUrl"]
    
}

extension URL: INavigatable {
    public static func create() -> Any? {
        return nil
    }
}

extension ViewController: INavigatable {
    
    static func create() -> Any? {
        return ViewController()
    }
}

extension TestViewController: INavigatable {
    
    static func create() -> Any? {
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
            .map(ids: Route.root, location: .type(ViewController.self)){
                [weak self] (event) in
                
                    let navigation = UINavigationController(rootViewController: event.destination)
                    self?.window.rootViewController = navigation
            }
            .map(ids: Route.screenOne, location: .type(TestViewController.self)) {
                (event) in
            }
            .map(ids: Route.openUrl, location: .instance(URL(string: "https://www.google.com")!)) {
                (event) in
                UIApplication.shared.open(event.destination,
                                          options: [:],
                                          completionHandler: nil)
        }
        
        manager
            .mapPathNotFound(observer: { (_, _) in
            
            })
        
    }
    
}
