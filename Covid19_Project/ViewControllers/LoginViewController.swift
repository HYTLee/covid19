//
//  ViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit
import KeychainAccess

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginTopConstarint: NSLayoutConstraint!
    
    
    var loginData: String?
    let keychain = Keychain(service: "com.hramiashkevich.Covid19-Project")
    let keychainKeyForPassword = "userPassword"

    
    
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
        super.viewDidAppear(animated)
        loginTopConstarint.constant = 120
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseOut], animations: {
          [weak self] in self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            if ((loginTextField.text != "") && (passwordTextField.text != "")){
                loginBtn.isEnabled = true
                
            }
            else {
                loginBtn.isEnabled = false
                
            }
        }
    
    @IBAction func loginAction(_ sender: UIButton) {
        openNewsView()
        savePasswordToKeyChain()
        cleanTextfieldsAndDisableLoginBtn()
    }
    
    @IBAction func tryToSetLastSuccessPasswordAction(_ sender: UIButton) {
        getPasswordFromKeChain()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if (string == " ") {
              return false
            }
            return true
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
        
    }
    
    func cleanTextfieldsAndDisableLoginBtn()  {
        self.loginTextField.text = ""
        self.passwordTextField.text = ""
        loginBtn.isEnabled = false
    }
    
    
    func saveLogin(loginText: String)  {
        let userLoginKey = "lastUserLogin"
        UserDefaults.standard.string(forKey: userLoginKey)
        UserDefaults.standard.setValue(loginText, forKey: userLoginKey)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func unwindFromProfile(_ sender: UIStoryboardSegue) {
        
    }
}

extension LoginViewController {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}


extension LoginViewController {
    func savePasswordToKeyChain() {
        let password = self.passwordTextField.text
        print("password is \(password ?? "")")
        
        if passwordTextField.text != nil {
            DispatchQueue.global().async {
                do {    
                    // Should be the secret invalidated when passcode is removed? If not then use `.WhenUnlocked`
                    try self.keychain
                        .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
                        .set( password ?? "", key: self.keychainKeyForPassword)
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    func getPasswordFromKeChain() {
        DispatchQueue.global().async {
            do {
                let password = try self.keychain
                    .authenticationPrompt("Authenticate to login to server")
                    .get(self.keychainKeyForPassword)

                print("password is: \(password ?? "")")
                DispatchQueue.main.async {
                    if password != nil{
                    self.passwordTextField.text = password
                    self.loginBtn.isEnabled = true
                    }
                }
            } catch let error {
                print(error)
            }
        }    }
    
    func updatePassword() {
        let password = self.passwordTextField.text ?? ""
        DispatchQueue.global().async {
            do {
                // Should be the secret invalidated when passcode is removed? If not then use `.WhenUnlocked`
                try self.keychain
                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
                    .authenticationPrompt("Authenticate to update your access token")
                    .set(password, key: self.keychainKeyForPassword)
            } catch let error {
                print(error)
            }
        }
    }
    
    func deletePasswordKeyChain()  {
        do {
            try self.keychain.remove(keychainKeyForPassword)
        } catch let error {
            print(error)
        }
    }

}
