//
//  ViewController.swift
//  Demo
//
//  Created by Gerald Adorza on 29/9/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import UIKit
import Navigator

final class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(pushDetail)
        )
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func pushDetail() {
        Navigator.shared.navigate(id: Route.openUrl.first)
    }
}

final class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(pushDetail)
        )
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func pushDetail() {
        Navigator.shared.navigate(id: Route.detail.first)
    }
}

