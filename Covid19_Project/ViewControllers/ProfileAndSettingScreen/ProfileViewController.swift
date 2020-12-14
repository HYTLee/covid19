//
//  ProfileViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit


class ProfileViewController: UIViewController {

    var profileName:String!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var notificationTextField: UITextField!
    
    let timePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    let notification = Notification()
    
    var dateFromPicker = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = profileName
        self.profileNameLabel.text = profileName
        self.setLogoutButton()
        self.setNotificationBtn()
        self.setNotificationTextField()
        self.setDatePicker()
        self.setToolBar()
        notificationTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notification.getNotificationPermission()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setDatePicker()  {
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
    }
    
    func setToolBar()  {
        let okBtn = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(okAction))
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelAction))
        toolBar.setItems([okBtn, cancelBtn], animated: true)
        toolBar.sizeToFit()

    }
    
    func setLogoutButton()  {
        logoutBtn.layer.cornerRadius = 0.2 * logoutBtn.bounds.size.width
        logoutBtn.setTitle(NSLocalizedString("Logout", comment: "You like the result?"), for: .normal)
        logoutBtn.clipsToBounds = true
    }
    
    func setNotificationTextField()  {
        notificationTextField.inputView = timePicker
        notificationTextField.inputAccessoryView = toolBar
    }
    
    func setNotificationBtn()  {
        notificationBtn.layer.cornerRadius = 0.2 * logoutBtn.bounds.size.width
        notificationBtn.clipsToBounds = true
        notificationBtn.isEnabled = false
        notificationBtn.backgroundColor = .lightGray
        notificationBtn.setTitle(NSLocalizedString("Set Notification", comment: "You like the result?"), for: .normal)
    }
    
    func setTimeForNotification()  {
        let date = dateFromPicker
        if dateFromPicker != nil{
            let components = Calendar.current.dateComponents([.hour, .minute], from: date)
            notification.dateComponents.hour = components.hour ?? 10
            notification.dateComponents.minute = components.minute ?? 0
        }

    }
    
    @IBAction func setNotification(_ sender: UIButton){
        notification.remodeAllScheduledNotifications()
        setTimeForNotification()
        notification.scheduleNotification()
    }
    
    
    @objc func okAction(){
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .short
        dateFromPicker = timePicker.date
        let stringDate = dateFormater.string(from: dateFromPicker)
        notificationTextField.text = stringDate
        self.view.endEditing(true)
    }
    
    
    @objc func cancelAction(){
        self.view.endEditing(true)
    }
    
    @IBAction func openShareScreen(_ sender: UIButton) {
        
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if notificationTextField.text != "" {
            notificationBtn.isEnabled = true
        }  else {
            notificationBtn.isEnabled = false
        }
    }
}
