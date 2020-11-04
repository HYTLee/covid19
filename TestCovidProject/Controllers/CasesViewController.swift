//
//  CasesViewController.swift
//  TestCovidProject
//
//  Created by AP Yauheni Hramiashkevich on 11/1/20.
//

import UIKit

class CasesViewController: UIViewController {
    
    let statisticsTable = UITableView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    
    var country: [Country] = [
    Country(country: "Usa", latest: Latest(confirmed: 10, deaths: 2)),
    Country(country: "Belarus", latest: Latest(confirmed: 2, deaths: 0)),

    
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        statisticsTable.dataSource = self
        statisticsTable.delegate = self
        setStatisticsTable()
        statisticsTable.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryCell")
    }
    
    
    func setStatisticsTable()  {
        self.view.addSubview(statisticsTable)
        statisticsTable.translatesAutoresizingMaskIntoConstraints = false
       // statisticsTable.separatorStyle = .none
        
        let tableTopConstr = NSLayoutConstraint(
            item: statisticsTable,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: 0)
        
        let tableBotConstr = NSLayoutConstraint(
            item: statisticsTable,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0)
        
        let tableLeftConstr = NSLayoutConstraint(
            item: statisticsTable,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .leading,
            multiplier: 1,
            constant: 0)
        
        let tableRightConstr = NSLayoutConstraint(
            item: statisticsTable,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .trailing,
            multiplier: 1,
            constant: 0)
        
        
        self.view.addConstraints([tableTopConstr, tableBotConstr, tableLeftConstr, tableRightConstr])
    }
    
    

}


extension CasesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        country.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryCell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryTableViewCell
    
        countryCell.textLabel?.text = "Country: \(country[indexPath.row].country)  Cases: \(String(country[indexPath.row].latest.confirmed)) Dead: \(String(country[indexPath.row].latest.deaths)) "
        
        return countryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CasesDetailsViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.countryLabel.text = "Country: \(country[indexPath.row].country)"
        vc.casesLabel.text = "Confirmed cases: \(String(country[indexPath.row].latest.confirmed))"
        vc.deathLabel.text = "Dead: \(String(country[indexPath.row].latest.deaths))"

    }
    
    
}
