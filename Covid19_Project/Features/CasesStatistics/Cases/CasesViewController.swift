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
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    private var casesViewModel = ContainerDependancies.container.resolve(CaseViewModel.self)
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
        selectRowFromTableView()
      // setSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.deselectSelectedRow(animated: true)
    }
    
   private func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {[weak self] in
                    self?.tableView.refreshControl?.endRefreshing()}
        ).disposed(by: disposeBag)
   }
    
  
    
    private func tableViewRefreshAfterPositiveResponse(){
        self.loader.stopAnimating()
        self.tableView.refreshControl?.endRefreshing()
        self.loader.isHidden = true
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.tableView.reloadData()
    }
    
    
    private func setDataForTableView() {
            casesViewModel?.cases?
                    .bind(to: tableView
                      .rx
                      .items(cellIdentifier: "CountryCell",
                             cellType: CountryTableCell.self)) { row, response, cell in
                        cell.textLabel?.text = "\(response.country ?? "\(NSLocalizedString("Unknown country", comment: "Unknown country"))")  \(NSLocalizedString("Cases", comment: "Cases")): \(response.infected ?? 0)  \(NSLocalizedString("Recovered", comment: "Recovered")): \(response.recovered ?? 0) "
                    }
                    .disposed(by: disposeBag)
            self.tableViewRefreshAfterPositiveResponse()
    }
       
    func selectRowFromTableView()  {
        tableView
            .rx
            .modelSelected(Case.self)
            .subscribe(onNext: {[weak self] aCase in
                guard let strongSelf = self else {return}
                guard let caseDetailsVC = strongSelf.storyboard?.instantiateViewController(identifier: "CaseDetailsViewController") as? CassesDetailsViewController else {
                    fatalError("Task not found")
                }
                strongSelf.navigationController?.pushViewController(caseDetailsVC, animated: true)
                caseDetailsVC.countryCase = aCase
            }).disposed(by: disposeBag)
    }
}





