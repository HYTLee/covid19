//
//  CassesDetailsViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 11/1/20.
//

import UIKit

class CassesDetailsViewController: UIViewController {

    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var casesLabel: UILabel!
    
    var country = "Country"
    var death = 0
    var cases = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deathLabel.text = "Death: \(String(death))"
        casesLabel.text = "Cases: \(cases)"
        self.title = country
    }
    

   
}
