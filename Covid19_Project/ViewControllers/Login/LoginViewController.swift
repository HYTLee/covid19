//
//  ViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit
import KeychainAccess
import RealmSwift


class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginTopConstarint: NSLayoutConstraint!
    @IBOutlet weak var addLastSuccesPasswordBtn: UIButton!
    @IBOutlet weak var registrationBtn: UIButton!
    @IBOutlet weak var skipLoginBtn: UIButton!
    
    
    let app = App(id: "application-0-tmrap")
    var loginData: String?
    let keychain = Keychain(service: "com.hramiashkevich.Covid19-Project")
    let keychainKeyForPassword = "userPassword"


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginTextField()
        setPasswordTextField()
        setLastPasswordBtn()
        setLoginBtn()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        }
    
    func setLoginTextField()  {
        let formatString = NSLocalizedString("Enter login",comment: "Enter login placeholder")
        loginTextField.placeholder = String.localizedStringWithFormat(formatString)
    }
    
    func setPasswordTextField()  {
        let formatString = NSLocalizedString("Enter password",comment: "Enter password placeholder")
        passwordTextField.placeholder = String.localizedStringWithFormat(formatString)
    }
    
    func setLoginBtn()  {
        loginBtn.isEnabled = false
        loginBtn.setTitle(NSLocalizedString("Login", comment: "Login button text"), for: .normal)
    }
    
    func setLastPasswordBtn()  {
        addLastSuccesPasswordBtn.setTitle(NSLocalizedString("Password", comment: "Password buttn text"), for: .normal)
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
       login()
    }
    
    private func login() {
        app.login(credentials: Credentials.emailPassword(email: loginTextField.text!, password: passwordTextField.text!)) { result in
            switch result {
            case .failure(let error):
                print("Login failed: \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "OOOps", message: "Please register your account", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            case .success(let user):
                print("Login as \(user) succeeded!")
                // Continue below
                DispatchQueue.main.async {
                    self.openNewsView()
                    self.savePasswordToKeyChain()
                    self.cleanTextfieldsAndDisableLoginBtn()
                }
            }
        }
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
    
    
    func openNewsView(){
        self.loginData = loginTextField.text!
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "TabBarController") as! TabBarController
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
    
    @IBAction func registrationAction(_ sender: UIButton) {
        
            if loginTextField.text != "" && passwordTextField.text != "" {
                self.registerUser(email: loginTextField.text!, password: passwordTextField.text!)
            } else
            {
                let alert = UIAlertController(title: "OOOps", message: "Please fill all fields", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }


    }
    
    private func registerUser(email: String, password: String) {
        let client = app.emailPasswordAuth
        client.registerUser(email: email, password: password) { (error) in
            guard error == nil else {
                print("Failed to register: \(error!.localizedDescription)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "OOPs", message: "Please try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            // Registering just registers. You can now log in.
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Success", message: "Now you can log in", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func loginWithoutAuthorithation(_ sender: Any) {
        app.login(credentials: Credentials.anonymous) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("error is \(error.localizedDescription)")
                    self.showAlertSmthWentWrong()
                case .success(let user):
                    print(user)
                    self.pushNewsViewControllerForAnonimousUser()
                }
            }
        }
    }
    
    func pushNewsViewControllerForAnonimousUser()  {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = story.instantiateViewController(identifier: "TabBarController") as! TabBarController
        tabBarController.dataPass = "Anonimous"
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    func showAlertSmthWentWrong()  {
        let alertController = UIAlertController(title: "OOOPs",
                                                message: "Smth went wrong",
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .destructive) { alert in
          alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
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

            //    print("password is: \(password ?? "")")
                DispatchQueue.main.async {
                    if password != nil{
                    self.passwordTextField.text = password
                        if self.loginTextField.text != "" {
                    self.loginBtn.isEnabled = true
                        }
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
