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
    
    private var country = "\(NSLocalizedString("Country", comment: "Country"))"
    private var recovered = 0
    private var cases = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatistics()
        deathLabel.text = "\(NSLocalizedString("Recovered", comment: "Recovered")): \(String(recovered))"
        casesLabel.text = "\(NSLocalizedString("Cases", comment: "Cases")): \(cases)"
        self.title = country
    }
    
    override func viewWillAppear(_ animated: Bool) {
    //    self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      //  self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setStatistics()  {
        self.country = countryCase.country ?? "\(NSLocalizedString("Unknown country", comment: "Unknown country"))"
        self.recovered = countryCase.recovered ?? 0
        self.cases = countryCase.infected ?? 0
    }
    

   
}
