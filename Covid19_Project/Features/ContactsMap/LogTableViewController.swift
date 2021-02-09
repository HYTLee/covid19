//
//  LogTableViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/3/21.
//

import UIKit
import RealmSwift

class LogTableViewController: UITableViewController {

    var contact = try! Realm().objects(Contact.self)
      .sorted(byKeyPath: "name", ascending: true)
    
    let realm = try! Realm()

    @IBAction func scopeChanged(sender: Any) {
      
    }
    
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

  extension LogTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
      let searchResultsController = searchController.searchResultsController as! UITableViewController
      searchResultsController.tableView.reloadData()
    }
  }

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
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            try! realm.write() {
              
                let cont = contact[indexPath.row]
                realm.delete(cont)
              }
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cont = contact[indexPath.row]
        
        
        if cont.category.name == "Infected" {
            cell.backgroundColor = .red
        } else if cont.category.name == "Uninfected" {
            cell.backgroundColor = .green
        } else if cont.category.name == "Not sure" {
            cell.backgroundColor = .gray
        }
    }
    
  }

