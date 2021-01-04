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
}
