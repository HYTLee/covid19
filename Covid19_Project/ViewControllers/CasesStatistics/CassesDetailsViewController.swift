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
    var countryCase = Case()
    
    var country = "Country"
    var recovered = 0
    var cases = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatistics()
        deathLabel.text = "Recovered: \(String(recovered))"
        casesLabel.text = "Cases: \(cases)"
        self.title = country
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setStatistics()  {
        self.country = countryCase.country ?? "Unknown Country"
        self.recovered = countryCase.recovered ?? 0
        self.cases = countryCase.infected ?? 0
    }
    

   
}
