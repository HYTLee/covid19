//
//  ProfileViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileName:String!
    
    override func viewDidLoad() {
        print(profileName ?? 0)
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = profileName

    }
    
}
