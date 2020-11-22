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
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var notificationBtn: UIButton!
    
    let notification = Notification()
    
    override func viewDidLoad() {
        print(profileName ?? 0)
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = profileName
        self.profileNameLabel.text = profileName
        self.setLogoutButton()
        self.setNotificationBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notification.getNotificationPermission()
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setLogoutButton()  {
        logoutBtn.layer.cornerRadius = 0.2 * logoutBtn.bounds.size.width
        logoutBtn.clipsToBounds = true
    }
    
    func setNotificationBtn()  {
        notificationBtn.layer.cornerRadius = 0.2 * logoutBtn.bounds.size.width
        notificationBtn.clipsToBounds = true
        notificationBtn.backgroundColor = .lightGray
        notificationBtn.setTitle("Set Notification", for: .normal)
    }
    
    func setTimeForNotification()  {
        let date = timePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        notification.dateComponents.hour = components.hour ?? 10
        notification.dateComponents.minute = components.minute ?? 0
    }
    
    @IBAction func setNotification(_ sender: UIButton) {
        setTimeForNotification()
        notification.scheduleNotification()
    }
}
