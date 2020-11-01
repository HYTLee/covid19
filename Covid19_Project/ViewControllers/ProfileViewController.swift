//
//  ProfileViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileName:String!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        print(profileName ?? 0)
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = profileName
        self.profileNameLabel.text = profileName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
