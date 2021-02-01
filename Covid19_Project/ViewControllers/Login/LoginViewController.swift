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
    
    private let loginViewModel = ContainerDependancies.container.resolve(LoginViewModel.self)


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLoginTextField()
        self.setPasswordTextField()
        self.setLastPasswordBtn()
        self.setLoginBtn()
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self

        self.loginViewModel?.setStyleForLoginScreen(colorsForStyle: {[weak self] appStyle in
            self?.view.backgroundColor = appStyle.appBackGroundColor
            self?.loginTextField.textColor = appStyle.appTextColor
            self?.passwordTextField.textColor = appStyle.appTextColor
        })
        }
    
    private func setLoginTextField()  {
    loginTextField.placeholder = loginViewModel?.loginTextfieldPlaceholder
    }
    
    private func setPasswordTextField()  {
    passwordTextField.placeholder = loginViewModel?.passwordTexttieldPlaceholder
    }
    
    private func setLoginBtn()  {
        loginBtn.isEnabled = (loginViewModel?.isLoginButtonEnable == true)
        loginBtn.setTitle(loginViewModel?.loginButtonTitle, for: .normal)
    }
    
    private func setLastPasswordBtn()  {
    addLastSuccesPasswordBtn.setTitle(loginViewModel?.lastPasswordButtonTitle, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTopConstarint.constant += view.bounds.height
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loginTextField.text = loginViewModel?.setLoginFromUserDefaults()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginTopConstarint.constant = 120
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseOut], animations: {
          [weak self] in self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginBtn.isEnabled = (loginViewModel?.checkThatLoginAndPasswordFieldsAreFullfilled(loginText: loginTextField.text ?? "", passwordText: passwordTextField.text ?? "") == true)
    }
    
    @IBAction private func loginAction(_ sender: UIButton) {
       login()
    }
    
    private func login() {
        self.loginBtn.isEnabled = false
        app.login(credentials: Credentials.emailPassword(email: loginTextField.text!, password: passwordTextField.text!)) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: NSLocalizedString("OOOps", comment: "OOOps"), message: NSLocalizedString("Please register your account", comment: "Please register your account"), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.loginBtn.isEnabled = true
                }
            case .success(let user):
                DispatchQueue.main.async {
                    self.openNewsView()
                    self.loginViewModel?.savePasswordToKeyChain(passwordText: self.passwordTextField.text ?? "")
                    self.loginViewModel?.cleanTextfieldsAndDisableLoginBtn(buttonDisabling: { (loginText, passwordText) in
                        self.loginTextField.text = loginText
                        self.passwordTextField.text = passwordText
                        self.loginBtn.isEnabled = false
                    })
                }
            }
        }
    }
    
    @IBAction private func tryToSetLastSuccessPasswordAction(_ sender: UIButton) {
        self.loginViewModel?.getPasswordFromKeyChain(addPasswordToField: { (password) in
            if password != "" {
            self.passwordTextField.text = password
                if self.loginTextField.text != "" {
                    if self.containerFieldValidator?.validateFields(loginTextFieldText: self.loginTextField.text!, passwordTextFieldText: self.passwordTextField.text!) == true {
                            self.loginBtn.isEnabled = true
                    }
                }
            }
        })
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
        loginViewModel?.saveLogin(loginText: self.loginTextField.text!)
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction private func unwindFromProfile(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction private func registrationAction(_ sender: UIButton) {
        self.loginViewModel?.startRegistrationProcess(loginText: loginTextField.text ?? "", passwordText: passwordTextField.text ?? "",
                                                      failAlert: {
            let alert = UIAlertController(title: NSLocalizedString("OOOps", comment: "OOOps"), message: NSLocalizedString("Please try again", comment: "Please try again"), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        },
                                                      showSucessAlert: {
            let alert = UIAlertController(title: NSLocalizedString("Success", comment: "Success"), message: NSLocalizedString("Now you can log in", comment: "Now you can log in"), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })

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


