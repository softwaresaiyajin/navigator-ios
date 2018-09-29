//
//  ViewController.swift
//  Demo
//
//  Created by Gerald Adorza on 29/9/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import UIKit
import Navigator

struct Route {
    
    static let dismiss = ["/"]
    static let main = ["/main"]
    static let screenOne = ["/screenOne"]
    static let screenTwo = ["/screenTwo"]
    
}

extension String: IPathIdentifier {
    public var stringIdentifier: String { return self }
}

extension UIViewController: IViewController {
    
    public static func create() -> UIViewController {
        return UIViewController()
    }
}

class TestViewController: UIViewController {}

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let manager = Navigator.shared
        
        manager.mapPathNotFound { (id, data) in
            
        }
        
        manager.map(ids: Route.main,
                    location: UIViewController.self) { (controller, data) in
            
        }
        
        manager.map(ids: Route.screenOne,
                    location: TestViewController()) { (controller, data) in
            
        }
        
        debugPrint("manager events \(manager.mappedLocations)")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

