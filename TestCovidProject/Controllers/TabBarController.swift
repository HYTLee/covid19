//
//  TabBarController.swift
//  TestCovidProject
//
//  Created by AP Yauheni Hramiashkevich on 11/1/20.
//

import UIKit

class TabBarController: UITabBarController {
    
    var userName = "1"

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [NewsViewController(), CasesViewController(), UserDataViewController()]
        tabBar.items?[0].title = "News"
        tabBar.items?[1].title = "Cases"
        tabBar.items?[2].title = "Login"
    }
    


}
