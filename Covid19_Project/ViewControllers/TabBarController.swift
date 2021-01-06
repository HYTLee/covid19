//
//  TabBarController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit

class TabBarController: UITabBarController {
    var dataPass: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.items?[0].title = NSLocalizedString("News", comment: "You like the result?")
        tabBar.items?[0].image = UIImage(named: "news.png")
        tabBar.items?[1].title = NSLocalizedString("Statistics", comment: "You like the result?")
        tabBar.items?[1].image = UIImage(named: "statistics.png")
        tabBar.items?[2].title = NSLocalizedString("Profile", comment: "You like the result?")
        tabBar.items?[2].image = UIImage(named: "profile.png")
        tabBar.items?[3].title = "Contacts map"
        
        let navController = self.viewControllers![2] as! UINavigationController
        let vc = navController.topViewController as! ProfileViewController
        vc.profileName = dataPass
    
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        print(dataPass ?? "Ooops")
        
 
    }
}
