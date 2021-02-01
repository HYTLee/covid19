//
//  LoginViewModelImplementation.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/28/21.
//

import Foundation
import KeychainAccess
import UIKit
import RealmSwift

class LogiViewModelImplementation: LoginViewModel {
    
    private let keychain = Keychain(service: "com.hramiashkevich.Covid19-Project")
    private let app = App(id: "application-0-tmrap")
    var loginData: String?
    var isLoginButtonEnable: Bool = false
    var loginButtonTitle: String = NSLocalizedString("Login", comment: "Login button text")
    var loginTextfieldPlaceholder: String = NSLocalizedString("Enter login",comment: "Enter login placeholder")
    var passwordTexttieldPlaceholder: String = NSLocalizedString("Enter password",comment: "Enter password placeholder")
    var lastPasswordButtonTitle: String = NSLocalizedString("Password", comment: "Password buttn text")
    private let keychainKeyForPassword = "userPassword"

    private let containerTimeCheck = ContainerDependancies.container.resolve(StyleProvider.self)
    private let containerFieldValidator = ContainerDependancies.container.resolve(FieldValidator.self)
    
    func setStyleForLoginScreen(colorsForStyle: @escaping (ApplicationStyle) -> Void)  {
        let appStyle = containerTimeCheck?.checkForDayOrNight() ?? AppDayStyle()
        colorsForStyle(appStyle)
    }
    
    func setLoginFromUserDefaults() -> String {
        let login = UserDefaults.standard.value(forKey: "lastUserLogin") as? String ?? ""
        return login
    }
    
    func checkThatLoginAndPasswordFieldsAreFullfilled(loginText: String, passwordText: String) -> Bool {
        if (containerFieldValidator?.validateFields(loginTextFieldText: loginText, passwordTextFieldText: passwordText) == true){
            return true
        }
        else {
            return false
        }
    }
    
    func saveLogin(loginText: String)  {
         let userLoginKey = "lastUserLogin"
         UserDefaults.standard.string(forKey: userLoginKey)
         UserDefaults.standard.setValue(loginText, forKey: userLoginKey)
     }
    
    func cleanTextfieldsAndDisableLoginBtn(buttonDisabling:(String, String) -> () )   {
        let loginString  = ""
        let passwordString = ""
        
        buttonDisabling(loginString, passwordString)
      }
    
    func savePasswordToKeyChain(passwordText: String) {
          let password = passwordText
          if passwordText != "" {
              DispatchQueue.global().async {
                  do {
                      // Should be the secret invalidated when passcode is removed? If not then use `.WhenUnlocked`
                      try self.keychain
                          .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
                          .set( password, key: self.keychainKeyForPassword)
                  } catch let error {
                      print(error)
                  }
              }
          }
      }
    
    func getPasswordFromKeyChain(addPasswordToField: @escaping (String) -> ()) {
         DispatchQueue.global().async {
             do {
                 let password = try self.keychain
                     .authenticationPrompt("Authenticate to login to server")
                     .get(self.keychainKeyForPassword)

                 DispatchQueue.main.async {
                    addPasswordToField(password ?? "")
                 }
             } catch let error {
                 print(error)
             }
         }
    }
    
    func updatePassword(passwordText: String?) {
         let password = passwordText ?? ""
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
    
    func registerUser(email: String, password: String, showFailAlert: @escaping ()-> (), showSucessAlert: @escaping () ->()) {
        let client = app.emailPasswordAuth
        client.registerUser(email: email, password: password) { (error) in
            guard error == nil else {
                DispatchQueue.main.async {
                   showFailAlert()
                }
                return
            }
            showSucessAlert()
        }
    }
    
    func startRegistrationProcess(loginText: String, passwordText: String, failAlert:@escaping () -> (), showSucessAlert: @escaping () -> ())  {
        if loginText != "" && passwordText != "" {
            self.registerUser(email: loginText, password: passwordText) {
                failAlert()
            } showSucessAlert: {
                showSucessAlert()
            }

        } else
        {
            failAlert()
        }

    }
    
    
    /*
     private func registerUser(email: String, password: String) {
         let client = app.emailPasswordAuth
         client.registerUser(email: email, password: password) { (error) in
             guard error == nil else {
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
     }*/
}
