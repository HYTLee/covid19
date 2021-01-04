//
//  CategoryTableViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/3/21.
//

import UIKit
import RealmSwift


//
// MARK: - Categories Table View Controller
//
class CategoriesTableViewController: UITableViewController {
  //
  // MARK: - Variables And Properties
  //
    let realm = try! Realm()
    lazy var categories: Results<Category> = { self.realm.objects(Category.self) }()
    var selectedCategory: Category!

  //
  // MARK: - View Controller
  //
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    self.populateDefaultCategories()
  }
    
    private func populateDefaultCategories() {
        if categories.count == 0 {
        try! realm.write() {
          let defaultCategories =
            ["Infected", "Uninfected", "Not sure" ]
          
          for category in defaultCategories {
            let newCategory = Category()
            newCategory.name = category
            
            realm.add(newCategory)
          }
        }
        
        categories = realm.objects(Category.self)
      }
    }
    
    @IBAction func addNewCategoryBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: "Add category", message: "Enter new category", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter category"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            try! self.realm.write(){
               let newCategory = Category()
                newCategory.name = textField?.text ?? "Default name"
                self.realm.add(newCategory)
                self.tableView.reloadData()
            }
        }))

        self.present(alert, animated: true, completion: nil)

    }
    
    
}

extension CategoriesTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
  
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedCategory = categories[indexPath.row]
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            try! realm.write() {
              
                let category = categories[indexPath.row]
                realm.delete(category)
              }
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
}
