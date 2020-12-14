//
//  ShareViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 12/13/20.
//

import UIKit
import ContactsUI
import MessageUI



class ShareViewController: UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func openUIContacts(_ sender: UIButton) {
        let contacVC = CNContactPickerViewController()
        contacVC.delegate = self
        self.present(contacVC, animated: true, completion: nil)
    }
    
    // MARK: Delegate method CNContectPickerDelegate
   func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
       print(contact.emailAddresses)
       let email = contact.emailAddresses.first
    print((email?.value) ?? "")
       
       self.emailLabel.text = "\((email?.value) ?? "hytl1971@gmail.com")"
    shareBtn.isEnabled = true
   }

   func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
       self.dismiss(animated: true, completion: nil)
   }
    
    @IBAction func shareWithChoosedEmail(_ sender: UIButton) {
        showEmailForm()
    }
    
    func showEmailForm()  {
        guard MFMailComposeViewController.canSendMail() else {
            // show alert that user can't sent email
            print("OOps you can't sent email")
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([emailLabel.text ?? "hytl1971@gmail.com"])
        composer.setSubject("Check my new Covid 19 app")
        composer.setMessageBody("You can download it here https://github.com/HYTLee/covid19", isHTML: false)
        
        present(composer, animated: true)
    }   
    
}

extension ShareViewController: MFMailComposeViewControllerDelegate{
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: false)
            return
        }
        
        switch result {
        case .cancelled:
            print("Canceled")
        case .failed:
            print("Failed")
        case .saved:
            print("Saved")
        case .sent:
            print("Sent")
        @unknown default:
            print("Unknown")
        }
        controller.dismiss(animated: true)
    }
    
}
