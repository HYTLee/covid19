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

    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginBtn: UIButton!
    @IBOutlet private weak var loginTopConstarint: NSLayoutConstraint!
    @IBOutlet private weak var addLastSuccesPasswordBtn: UIButton!
    @IBOutlet private weak var registrationBtn: UIButton!
    @IBOutlet private weak var skipLoginBtn: UIButton!
    
    
    private let app = App(id: "application-0-tmrap")
    private var loginData: String?
    private let keychain = Keychain(service: "com.hramiashkevich.Covid19-Project")
    private let keychainKeyForPassword = "userPassword"    
    private let containerFieldValidator = ContainerDependancies.container.resolve(FieldValidator.self)


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLoginTextField()
        self.setPasswordTextField()
        self.setLastPasswordBtn()
        self.setLoginBtn()
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        self.setStyleForLoginScreen()
        }
    

    
    func setStyleForLoginScreen()  {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)

        if hour <= 18 && hour >= 8 {
            let containerAppStyle = ContainerDependancies.container.resolve(ApplicationStyle.self, name: "Day")
            self.view.backgroundColor = containerAppStyle?.appBackGroundColor
            self.loginTextField.textColor = containerAppStyle?.appTextColor
        } else
        {
            let containerAppStyle = ContainerDependancies.container.resolve(ApplicationStyle.self, name: "Night")
            self.view.backgroundColor = containerAppStyle?.appBackGroundColor
            self.loginTextField.textColor = containerAppStyle?.appTextColor
            
        }
    }
    
   private func setLoginTextField()  {
        let formatString = NSLocalizedString("Enter login",comment: "Enter login placeholder")
        loginTextField.placeholder = String.localizedStringWithFormat(formatString)
    }
    
   private func setPasswordTextField()  {
        let formatString = NSLocalizedString("Enter password",comment: "Enter password placeholder")
        passwordTextField.placeholder = String.localizedStringWithFormat(formatString)
    }
    
   private func setLoginBtn()  {
        loginBtn.isEnabled = false
        loginBtn.setTitle(NSLocalizedString("Login", comment: "Login button text"), for: .normal)
    }
    
   private func setLastPasswordBtn()  {
        addLastSuccesPasswordBtn.setTitle(NSLocalizedString("Password", comment: "Password buttn text"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTopConstarint.constant += view.bounds.height
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loginTextField.text = UserDefaults.standard.value(forKey: "lastUserLogin") as? String
        self.skipLoginBtn.isEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginTopConstarint.constant = 120
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseOut], animations: {
          [weak self] in self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (containerFieldValidator?.validateFields(loginTextFieldText: loginTextField.text!, passwordTextFieldText: passwordTextField.text!) == true){
            loginBtn.isEnabled = true
        }
        else { loginBtn.isEnabled = false
        }
    }
    
    @IBAction private func loginAction(_ sender: UIButton) {
       login()
    }
    
    private func login() {
        self.loginBtn.isEnabled = false
        app.login(credentials: Credentials.emailPassword(email: loginTextField.text!, password: passwordTextField.text!)) { result in
            switch result {
            case .failure(let error):
                print("Login failed: \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: NSLocalizedString("OOOps", comment: "OOOps"), message: NSLocalizedString("Please register your account", comment: "Please register your account"), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.loginBtn.isEnabled = true
                }
            case .success(let user):
                DispatchQueue.main.async {
                    self.openNewsView()
                    self.savePasswordToKeyChain()
                    self.cleanTextfieldsAndDisableLoginBtn()
                }
            }
        }
    }
    
    @IBAction private func tryToSetLastSuccessPasswordAction(_ sender: UIButton) {
        getPasswordFromKeyChain()
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
    
    
   private func openNewsView(){
        let loginStrings : [String] = loginTextField.text!.components(separatedBy: "@")
        self.loginData = loginStrings[0]
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "TabBarController") as! TabBarController
        controller.dataPass = self.loginData
        self.navigationController?.pushViewController(controller, animated: true)
        saveLogin(loginText: self.loginTextField.text!)
        
    }
    
  private func cleanTextfieldsAndDisableLoginBtn()  {
        self.loginTextField.text = ""
        self.passwordTextField.text = ""
        loginBtn.isEnabled = false
    }
    
    
   private func saveLogin(loginText: String)  {
        let userLoginKey = "lastUserLogin"
        UserDefaults.standard.string(forKey: userLoginKey)
        UserDefaults.standard.setValue(loginText, forKey: userLoginKey)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction private func unwindFromProfile(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction private func registrationAction(_ sender: UIButton) {
        
            if loginTextField.text != "" && passwordTextField.text != "" {
                self.registerUser(email: loginTextField.text!, password: passwordTextField.text!)
            } else
            {
                let alert = UIAlertController(title: NSLocalizedString("OOOps", comment: "OOOps"), message: NSLocalizedString("Please fill all fields", comment: "Please fill all fields"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }


    }
    
    private func registerUser(email: String, password: String) {
        let client = app.emailPasswordAuth
        client.registerUser(email: email, password: password) { (error) in
            guard error == nil else {
              //  print("Failed to register: \(error!.localizedDescription)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: NSLocalizedString("OOOps", comment: "OOOps"), message: NSLocalizedString("Please try again", comment: "Please try again"), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            // Registering just registers. You can now log in.
            DispatchQueue.main.async {
                let alert = UIAlertController(title: NSLocalizedString("Success", comment: "Success"), message: NSLocalizedString("Now you can log in", comment: "Now you can log in"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction private func loginWithoutAuthorithation(_ sender: Any) {
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
        self.skipLoginBtn.isEnabled = false
    }
    
    private func pushNewsViewControllerForAnonimousUser()  {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = story.instantiateViewController(identifier: "TabBarController") as! TabBarController
        tabBarController.dataPass = "Anonimous"
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    private func showAlertSmthWentWrong()  {
        let alertController = UIAlertController(title: NSLocalizedString("OOOps", comment: "OOOps"),
                                                message: NSLocalizedString("Something went wrong", comment: "Something went wrong"),
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .destructive) { alert in
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
  private func savePasswordToKeyChain() {
        let password = self.passwordTextField.text
       //print("password is \(password ?? "")")
        
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
    
   private func getPasswordFromKeyChain() {
        DispatchQueue.global().async {
            do {
                let password = try self.keychain
                    .authenticationPrompt("Authenticate to login to server")
                    .get(self.keychainKeyForPassword)

                DispatchQueue.main.async {
                    if password != nil{
                    self.passwordTextField.text = password
                        if self.loginTextField.text != "" {
                            if self.containerFieldValidator?.validateFields(loginTextFieldText: self.loginTextField.text!, passwordTextFieldText: self.passwordTextField.text!) == true {
                                    self.loginBtn.isEnabled = true
                            }
                        }
                    }
                }
            } catch let error {
                print(error)
            }
        }    }
    
   private func updatePassword() {
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
    
  private func deletePasswordKeyChain()  {
        do {
            try self.keychain.remove(keychainKeyForPassword)
        } catch let error {
            print(error)
        }
    }

}
