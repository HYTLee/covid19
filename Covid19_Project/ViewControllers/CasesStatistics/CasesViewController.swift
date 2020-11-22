//
//  CasesViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit
import Foundation

class CasesViewController: UIViewController {
    
    let loader = UIActivityIndicatorView()
    @IBOutlet weak var tableView: UITableView!
    var response = [Case]()

    
    func setLoader()  {
        self.view.addSubview(loader)
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        let loaderTopConstr = NSLayoutConstraint(
            item: loader,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerY ,
            multiplier: 1,
            constant: -100)
        
        let loaderLeftConstr = NSLayoutConstraint(
            item: loader,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: -100)
        
        
        let loaderHeightConstr = NSLayoutConstraint(
            item: loader,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 200)
        
        let loaderWidthConstr = NSLayoutConstraint(
            item: loader,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 200)
        
        self.view.addConstraints([loaderTopConstr, loaderLeftConstr, loaderHeightConstr, loaderWidthConstr])
        loader.isHidden = false
        loader.startAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Cases"
        setLoader()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        getStatisticsFromApi()
        configureRefreshControl()
        
    }
    func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       tableView.refreshControl = UIRefreshControl()
       tableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
       // Update your content…
        getStatisticsFromApi()
        
       // Dismiss the refresh control.
       DispatchQueue.main.async {
          self.tableView.refreshControl?.endRefreshing()
      //  print("Reload has been finished")
       }
    }
    
    
    
    func getStatisticsFromApi()  {
        let session = URLSession(configuration: .default)

        guard  let covidURL = URL(string: "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true")
        else {return}
        let urlRequest = URLRequest(url: covidURL)
       let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error{
                print(error)
        }
        
        if let data = data {
            do {
                self.response = try JSONDecoder().decode([Case].self, from: data)
                print(self.response.count)
                DispatchQueue.main.async { [weak self] in
                    self?.loader.stopAnimating()
                    self?.loader.isHidden = true
                    self?.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
                    self?.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        }
        dataTask.resume()
    }
    
}


extension CasesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryTableCell

        cell.textLabel?.text = "\(response[indexPath.row].country ?? "Unknown country")  Casses: \(response[indexPath.row].infected ?? 0)  Recovered: \(response[indexPath.row].recovered ?? 0) "
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            if let indexpath = self.tableView.indexPathForSelectedRow{
                let casesDetails = segue.destination as! CassesDetailsViewController
                casesDetails.countryCase = self.response[indexpath.row]
            }
        }
    }
        
    
}


