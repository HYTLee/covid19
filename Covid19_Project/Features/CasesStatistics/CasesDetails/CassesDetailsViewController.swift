//
//  CassesDetailsViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 11/1/20.
//

import UIKit
import RxCocoa
import RxSwift

class CassesDetailsViewController: UIViewController {

    @IBOutlet weak var recoverLabel: UILabel!
    @IBOutlet weak var casesLabel: UILabel!
    var countryCase = Case()
    
    private var country = "\(NSLocalizedString("Country", comment: "Country"))"
    private var recovered = 0
    private var cases = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatistics()
        recoverLabel.text = "\(NSLocalizedString("Recovered", comment: "Recovered")): \(String(recovered))"
        casesLabel.text = "\(NSLocalizedString("Cases", comment: "Cases")): \(cases)"
        self.title = country
    }
    
    private func setStatistics()  {
        self.country = countryCase.country ?? "\(NSLocalizedString("Unknown country", comment: "Unknown country"))"
        self.recovered = countryCase.recovered ?? 0
        self.cases = countryCase.infected ?? 0
    }
    

   
}
