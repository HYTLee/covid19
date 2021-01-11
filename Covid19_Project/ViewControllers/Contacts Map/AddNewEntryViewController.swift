//
//  AddNewEntryViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/3/21.
//

import UIKit
import RealmSwift

class AddNewEntryViewController: UIViewController {

    var selectedAnnotation: ContactAnnotation!
    var selectedCategory: Category!
    var contact: Contact!


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextFiled: UITextField!
    
    @IBAction func unwinWithoutSavingFromCategories(segue: UIStoryboardSegue) {

    }
    
    @IBAction func unwindFromCategories(segue: UIStoryboardSegue) {
          let categoriesController = segue.source as! CategoriesTableViewController
          self.selectedCategory = categoriesController.selectedCategory
          categoryTextField.text = selectedCategory.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryTextField.delegate = self
        
        if let contact = contact {
          title = "\(NSLocalizedString("Edit", comment: "Edit")) \(contact.name)"
              
          fillTextFields()
        } else {
          title = NSLocalizedString("Add New Contact", comment: "Add New Contact")
        }
    }
    
    func validateFields() -> Bool {
        if
          nameTextField.text!.isEmpty ||
          descriptionTextFiled.text!.isEmpty ||
          selectedCategory == nil {
        let alertController = UIAlertController(title: NSLocalizedString("Validation Error", comment: "Validation Error"),
                                                message: NSLocalizedString("Please fill all fields", comment: "Please fill all fields"),
                                                preferredStyle: .alert)
        
            let alertAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .destructive) { alert in
          alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
            
        return false
      } else {
        return true
      }
    }
    
    func fillTextFields() {
      nameTextField.text = contact.name
      categoryTextField.text = contact.category.name
      descriptionTextFiled.text = contact.contactDescription
      selectedCategory = contact.category
    }
    
    
    func addNewContact() {
      let realm = try! Realm()
        
      try! realm.write {
        let newContact = Contact()
          
        newContact.name = nameTextField.text!
        newContact.category = selectedCategory
        newContact.contactDescription = descriptionTextFiled.text!
        newContact.latitude = selectedAnnotation.coordinate.latitude
        newContact.longitude = selectedAnnotation.coordinate.longitude
          
        realm.add(newContact)
        contact = newContact 
      }
    }
    
    func updateContact() {
      let realm = try! Realm()
        
      try! realm.write {
        contact.name = nameTextField.text!
        contact.category = selectedCategory
        contact.contactDescription = descriptionTextFiled.text ?? NSLocalizedString("No additional info", comment: "No additional info")
      }
    }

    override func shouldPerformSegue(
      withIdentifier identifier: String,
      sender: Any?
      ) -> Bool {
        if validateFields() {
            if contact != nil {
                self.updateContact()
            } else {
                self.addNewContact()
            }
          return true
        } else {
          return false
        }
    }

}

extension AddNewEntryViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    performSegue(withIdentifier: "Categories", sender: self)
  }
}
