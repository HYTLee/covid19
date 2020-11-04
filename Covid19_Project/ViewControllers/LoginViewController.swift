//
//  ViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginTopConstarint: NSLayoutConstraint!
    
    
    var loginData = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.isEnabled = false
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTopConstarint.constant += view.bounds.height
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loginTextField.text = UserDefaults.standard.value(forKey: "lastUserLogin") as? String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loginTopConstarint.constant = 120
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseOut], animations: {
          [weak self] in self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            if ((loginTextField.text != "") && (passwordTextField.text != "")){
                loginBtn.isEnabled = true

            }else{
                loginBtn.isEnabled = false
            }
        }
    
    @IBAction func loginAction(_ sender: UIButton) {
        openNewsView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @objc func openNewsView(){
        self.loginData = loginTextField.text!
    
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "TabBarController") as! TabBarController
        let profileController = story.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        profileController.profileName = self.loginData
        controller.dataPass = self.loginData
        self.navigationController?.pushViewController(controller, animated: true)
        saveLogin(loginText: self.loginTextField.text!)
        self.loginTextField.text = ""
        self.passwordTextField.text = ""
        loginBtn.isEnabled = false
    }
    
    
    func saveLogin(loginText: String)  {
        let userLoginKey = "lastUserLogin"
        _ = UserDefaults.standard.string(forKey: userLoginKey)
        UserDefaults.standard.setValue(loginText, forKey: userLoginKey)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func unwindFromProfile(_ sender: UIStoryboardSegue) {
        
    }
    
    
   
        

}
