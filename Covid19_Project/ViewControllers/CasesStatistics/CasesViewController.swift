//
//  CasesViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift

class CasesViewController: UIViewController {
    
    private let loader = UIActivityIndicatorView()
    @IBOutlet private weak var tableView: UITableView!
    private let casesDownloader = ContainerDependancies.container.resolve(CaseDownloader.self)
    private let casesVM = CasesViewModelImplementation()
    private let disposeBag = DisposeBag()
    
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
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("Statistics", comment: "You like the result?")
        setLoader()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        setDataForTableView()
        configureRefreshControl()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.deselectSelectedRow(animated: true)
    }
    
   private func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       tableView.refreshControl = UIRefreshControl()
       tableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        casesDownloader?.getStatisticsFromApi { [self] in
            tableViewRefreshAfterPositiveResponse()
        }
    }
    
    private func tableViewRefreshAfterPositiveResponse(){
        self.loader.stopAnimating()
        self.tableView.refreshControl?.endRefreshing()
        self.loader.isHidden = true
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.tableView.reloadData()
    }
    
    private func setDataForTableView() {
        casesVM.getDataForTableView { [self] in
            casesVM.cases?
                    .bind(to: tableView
                      .rx
                      .items(cellIdentifier: "CountryCell",
                             cellType: CountryTableCell.self)) { row, response, cell in
                        cell.textLabel?.text = "\(response.country ?? "\(NSLocalizedString("Unknown country", comment: "Unknown country"))")  \(NSLocalizedString("Cases", comment: "Cases")): \(response.infected ?? 0)  \(NSLocalizedString("Recovered", comment: "Recovered")): \(response.recovered ?? 0) "
                    }
                    .disposed(by: disposeBag)
            self.tableViewRefreshAfterPositiveResponse()
        }
    }
       
    func setupCellTapHandling() {
      tableView
        .rx
        .modelSelected(Case.self) //1
        .subscribe(onNext: { [unowned self] chocolate in // 2
         
          if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
          } //4
        })
        .disposed(by: disposeBag) //5
    }
}


extension CasesViewController {
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowDetails" {
//            if let indexpath = self.tableView.indexPathForSelectedRow{
//                let casesDetails = segue.destination as! CassesDetailsViewController
//                casesDetails.countryCase = (casesDownloader?.response)
//            }
//
//        }
//    }
    
        
    
}


