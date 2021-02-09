//
//  ProfileViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit


class ProfileViewController: UIViewController {

    var profileName:String!
    
    

    @IBOutlet private weak var profileNameLabel: UILabel!
    @IBOutlet private weak var logoutBtn: UIButton!
    @IBOutlet private weak var notificationBtn: UIButton!
    @IBOutlet private weak var telegramBtn: UIButton!
    @IBOutlet private weak var shareBtn: UIButton!
    @IBOutlet private weak var notificationTextField: UITextField!
    @IBOutlet private weak var setNotificationLabel: UILabel!
    @IBOutlet private weak var homeLocationBtn: UIButton!
    
    private let timePicker = UIDatePicker()
    private let toolBar = UIToolbar()
    private let notification = Notification()
    private var dateFromPicker = Date()
    
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
    
    private func setShareBtn()  {
        shareBtn.setTitle(NSLocalizedString("Share", comment: "Share"), for: .normal)
        shareBtn.layer.cornerRadius = 0.1 * logoutBtn.bounds.size.width
        shareBtn.clipsToBounds = true
    }
    
    private func setNotificationLabelFunc()  {
        setNotificationLabel.text = NSLocalizedString("Set notification", comment: "Set notification")
    }
    
    private func setTelegramBtn()  {
        if let image = UIImage(named: "telegram.png"){
            
            telegramBtn.setBackgroundImage(image, for: .normal)
            telegramBtn.contentVerticalAlignment = .fill
            telegramBtn.contentHorizontalAlignment = .fill
            telegramBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        }
    }
    
    private func setHomeLocationBtn()  {
        homeLocationBtn.setTitle(NSLocalizedString("Home location", comment: "Home location btn title"), for: .normal)
    }
    
    private func setDatePicker()  {
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
    }
    
    private func setToolBar()  {
        let okBtn = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(okAction))
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelAction))
        toolBar.setItems([okBtn, cancelBtn], animated: true)
        toolBar.sizeToFit()

    }
    
    private func setLogoutButton()  {
        logoutBtn.layer.cornerRadius = 0.2 * logoutBtn.bounds.size.width
        logoutBtn.setTitle(NSLocalizedString("Logout", comment: "You like the result?"), for: .normal)
        logoutBtn.clipsToBounds = true
    }
    
    private func setNotificationTextField()  {
        notificationTextField.inputView = timePicker
        notificationTextField.inputAccessoryView = toolBar
        notificationTextField.placeholder = NSLocalizedString("Notification time", comment: "Notification time")
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        EventListnerManager.singleton.notify(event: .logout)
        EventListnerManager.singleton.unsubscribe(eventId: 1)
    }
    
    
    private func setNotificationBtn()  {
        notificationBtn.layer.cornerRadius = 0.2 * logoutBtn.bounds.size.width
        notificationBtn.clipsToBounds = true
        notificationBtn.isEnabled = false
        notificationBtn.backgroundColor = .lightGray
        notificationBtn.setTitle(NSLocalizedString("Set Notification", comment: "Set notification"), for: .normal)
    }
    
    private func setTimeForNotification()  {
        let date = dateFromPicker
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        notification.dateComponents.hour = components.hour ?? 10
        notification.dateComponents.minute = components.minute ?? 0
    }
    
    @IBAction private func setNotification(_ sender: UIButton){
        notification.remodeAllScheduledNotifications()
        setTimeForNotification()
        notification.scheduleNotification()
    }
    
    
    @objc private func okAction(){
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .short
        dateFromPicker = timePicker.date
        let stringDate = dateFormater.string(from: dateFromPicker)
        notificationTextField.text = stringDate
        self.view.endEditing(true)
    }
    
    
    @objc private func cancelAction(){
        self.view.endEditing(true)
    }
    
    @IBAction private func openShareScreen(_ sender: UIButton) {
    }
    
    @IBAction private func openTelegramLink(_ sender: Any) {
        if let url = URL(string: "tg://resolve?domain=G_Hytl") {
            UIApplication.shared.open(url)
        }
    }
    

    
    @IBAction private func openMapView(_ sender: Any) {
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
