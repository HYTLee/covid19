//
//  LogTableViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/3/21.
//

import UIKit
import RealmSwift

class LogTableViewController: UITableViewController {

    
    //
    // MARK: - Variables And Properties
    //
    var contact = try! Realm().objects(Contact.self)
      .sorted(byKeyPath: "name", ascending: true)
    //
    // MARK: - IBActions
    //
    @IBAction func scopeChanged(sender: Any) {
      
    }
    
    
    //
    // MARK: - View Controller
    //
    override func viewDidLoad() {
      super.viewDidLoad()
      
      self.tableView.delegate = self
      self.tableView.dataSource = self
      self.tableView.rowHeight = 63
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if (segue.identifier == "Edit") {
        let controller = segue.destination as! AddNewEntryViewController
        var selectedContact: Contact!
        let indexPath = tableView.indexPathForSelectedRow
    
        selectedContact = contact[indexPath!.row]
        controller.contact = selectedContact
      }
    }
  }



  //
  // MARK: - Search Results Updatings
  //
  extension LogTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
      let searchResultsController = searchController.searchResultsController as! UITableViewController
      searchResultsController.tableView.reloadData()
    }
  }

  //
  // MARK: - Table View Data Source
  extension LogTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.tableView.dequeueReusableCell(withIdentifier: "LogCell") as! LogCell
        let cont = contact[indexPath.row]
        cell.nameLabel.text = cont.name
        cell.detailsLabel.text = cont.category.name

      return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(contact.count)
      return  contact.count
    }
  }

