//
//  LoginViewModel.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/28/21.
//

import Foundation
import UIKit

protocol LoginViewModel {
    
    var loginButtonTitle: String {get}
    var isLoginButtonEnable: Bool {get set}
    var loginTextfieldPlaceholder: String {get}
    var passwordTexttieldPlaceholder: String {get}
    var lastPasswordButtonTitle: String {get}

    func setStyleForLoginScreen(colorsForStyle: @escaping (ApplicationStyle) -> Void)
    func setLoginFromUserDefaults() -> String
    func checkThatLoginAndPasswordFieldsAreFullfilled(loginText: String, passwordText: String) -> Bool
    func saveLogin(loginText: String)
    func cleanTextfieldsAndDisableLoginBtn(buttonDisabling:(String, String) -> () )
    func savePasswordToKeyChain(passwordText: String)
    func getPasswordFromKeyChain(addPasswordToField: @escaping (String) -> ())
    func updatePassword(passwordText: String?)
    func deletePasswordKeyChain()
    func registerUser(email: String, password: String, showFailAlert: @escaping ()-> (), showSucessAlert: @escaping () ->())
    func startRegistrationProcess(loginText: String, passwordText: String, failAlert:@escaping () -> (), showSucessAlert:@escaping () -> ())
}
