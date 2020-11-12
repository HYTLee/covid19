//
//  ViewController.swift
//  TestCovidProject
//
//  Created by AP Yauheni Hramiashkevich on 11/1/20.
//

import UIKit

class LoginViewController: UIViewController {

    let loginTextField = UITextField(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    let passwordTextField = UITextField(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    let loginBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    let userLoginKey = "Login Key"


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLoginLabel()
        setPasswordTextfield()
        setLoginBtn()
    }
    
    
    func  setLoginLabel() {
        self.view.addSubview(loginTextField)
        loginTextField.placeholder = "Set login"
        loginTextField.layer.borderWidth = 1
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.delegate = self
        
        
        let loginTopConstr = NSLayoutConstraint(
            item: loginTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: 180 + self.view.frame.height)
        
        let loginWidthConstr = NSLayoutConstraint(
            item: loginTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 200)
        
        let loginHeightConstr = NSLayoutConstraint(
            item: loginTextField,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 20)
        
        let loginCenterConstr = NSLayoutConstraint(
            item: loginTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)
        
        
        self.view.addConstraints([loginTopConstr, loginWidthConstr, loginHeightConstr, loginCenterConstr])
        
    }

    func  setPasswordTextfield() {
        self.view.addSubview(passwordTextField)
        passwordTextField.placeholder = "Set password"
        passwordTextField.layer.borderWidth = 1
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        let passTopConstr = NSLayoutConstraint(
            item: passwordTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: loginTextField,
            attribute: .bottom,
            multiplier: 1,
            constant: 20)
        
        let passWidthConstr = NSLayoutConstraint(
            item: passwordTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 200)
        
        let passHeightConstr = NSLayoutConstraint(
            item: passwordTextField,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 20)
        
        let passCenterConstr = NSLayoutConstraint(
            item: passwordTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)
        
        
        self.view.addConstraints([passTopConstr, passWidthConstr, passHeightConstr, passCenterConstr])
    }
    
    
    func setLoginBtn() {
        self.view.addSubview(loginBtn)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.backgroundColor = .lightGray
        loginBtn.setTitleColor(.blue, for: .normal)
        loginBtn.isEnabled = false
        
        
        
        let logBtnTopConstr = NSLayoutConstraint(
            item: loginBtn,
            attribute: .top,
            relatedBy: .equal,
            toItem: passwordTextField,
            attribute: .bottom,
            multiplier: 1,
            constant: 50)
        
        let logBtnWidthConstr = NSLayoutConstraint(
            item: loginBtn,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 200)
        
        let logBtnHeightConstr = NSLayoutConstraint(
            item: loginBtn,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 20)
        
        let logBtnCenterConstr = NSLayoutConstraint(
            item: loginBtn,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)
        
        
        self.view.addConstraints([logBtnTopConstr, logBtnWidthConstr, logBtnHeightConstr, logBtnCenterConstr])
        
        
        loginBtn.addTarget(self, action: #selector(openTabBarController), for: .touchUpInside)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func openTabBarController(){

        
        let tabBarVC = TabBarController()
        let userDataViewController = tabBarVC.viewControllers![2] as! UserDataViewController
        userDataViewController.userNameLabelText = self.loginTextField.text
        navigationController?.pushViewController(tabBarVC, animated: true)
        saveUserLogin(loginText: loginTextField.text ?? "Nothing to save")
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginTextField.text = UserDefaults.standard.value(forKey: userLoginKey) as? String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loginTopConstr = NSLayoutConstraint(
            item: loginTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: 180)
        self.view.addConstraint(loginTopConstr)
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        UIView.animate(withDuration: 2) {
            [weak self] in self?.view.layoutIfNeeded()
        }
    }
    
    func saveUserLogin(loginText: String)  {
        UserDefaults.standard.string(forKey: userLoginKey)
        UserDefaults.standard.setValue(loginText, forKey: userLoginKey)
    }
}



extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (loginTextField.text != "" && passwordTextField.text != "") {
            loginBtn.isEnabled = true
        }
        else {loginBtn.isEnabled = false}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
