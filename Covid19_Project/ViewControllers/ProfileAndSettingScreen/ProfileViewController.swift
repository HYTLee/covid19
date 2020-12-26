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
    @IBOutlet weak var telegramBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var notificationTextField: UITextField!
    @IBOutlet weak var setNotificationLabel: UILabel!
    @IBOutlet weak var homeLocationBtn: UIButton!
    
    let timePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    let notification = Notification()
    
    var dateFromPicker = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTelegramBtn()
        self.setShareBtn()
        self.navigationController?.navigationBar.topItem?.title = profileName
        self.profileNameLabel.text = profileName
        self.setLogoutButton()
        self.setNotificationLabelFunc()
        self.setNotificationBtn()
        self.setNotificationTextField()
        self.setDatePicker()
        self.setToolBar()
        self.setHomeLocationBtn()
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
    
    func setShareBtn()  {
        shareBtn.setTitle(NSLocalizedString("Share", comment: "Share"), for: .normal)
        shareBtn.layer.cornerRadius = 0.1 * logoutBtn.bounds.size.width
        shareBtn.clipsToBounds = true
    }
    
    func setNotificationLabelFunc()  {
        setNotificationLabel.text = NSLocalizedString("Set notification", comment: "Set notification")
    }
    
    func setTelegramBtn()  {
        if let image = UIImage(named: "telegram.png"){
            
            telegramBtn.setBackgroundImage(image, for: .normal)
            telegramBtn.contentVerticalAlignment = .fill
            telegramBtn.contentHorizontalAlignment = .fill
            telegramBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        }
    }
    
    func setHomeLocationBtn()  {
        homeLocationBtn.setTitle(NSLocalizedString("Home location", comment: "Home location btn title"), for: .normal)
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
        notificationTextField.placeholder = NSLocalizedString("Notification time", comment: "Notification time")
    }
    
    func setNotificationBtn()  {
        notificationBtn.layer.cornerRadius = 0.2 * logoutBtn.bounds.size.width
        notificationBtn.clipsToBounds = true
        notificationBtn.isEnabled = false
        notificationBtn.backgroundColor = .lightGray
        notificationBtn.setTitle(NSLocalizedString("Set Notification", comment: "Set notification"), for: .normal)
    }
    
    func setTimeForNotification()  {
        let date = dateFromPicker
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        notification.dateComponents.hour = components.hour ?? 10
        notification.dateComponents.minute = components.minute ?? 0
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
    
    @IBAction func openTelegramLink(_ sender: Any) {
        if let url = URL(string: "tg://resolve?domain=G_Hytl") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openMapView(_ sender: Any) {
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
