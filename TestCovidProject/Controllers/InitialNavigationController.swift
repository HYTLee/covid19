//
//  InitialNavigationController.swift
//  TestCovidProject
//
//  Created by AP Yauheni Hramiashkevich on 11/1/20.
//

import UIKit

class InitialNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginVC = LoginViewController()
        viewControllers = [loginVC]
        
    
        
    }
    
    
    



}
