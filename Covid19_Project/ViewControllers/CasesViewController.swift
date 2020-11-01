//
//  CasesViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit

class CasesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let inittialCountries: [Country] = [
        Country(country: "Belarus", Latest: Latest(confirmed: 20, death: 5) ),
        Country(country: "Swizeland", Latest: Latest(confirmed: 5, death: 0)),
        Country(country: "USA", Latest: Latest(confirmed: 1200, death: 100))
    ]
        
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Cases"


    }
    
}


extension CasesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  inittialCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryTableCell
    let country = inittialCountries[indexPath.row].country
        let confirmed = inittialCountries[indexPath.row].Latest.confirmed
        let death = inittialCountries[indexPath.row].Latest.death
        cell.countryLable.text = "\(country)    Confirmed: \(String(confirmed))   Death: \(String(death))"

        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            if let indexpath = self.tableView.indexPathForSelectedRow{
                let casesDetails = segue.destination as! CassesDetailsViewController
                casesDetails.death = inittialCountries[indexpath.row].Latest.death
                casesDetails.cases = inittialCountries[indexpath.row].Latest.confirmed
                casesDetails.country = inittialCountries[indexpath.row].country

                
            }
        }
    }
    
}
