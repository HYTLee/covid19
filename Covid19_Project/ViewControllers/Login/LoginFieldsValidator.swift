//
//  LoginFieldsValidator.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/12/21.
//

import Foundation
import UIKit


class LoginFieldsValidator {
    
    func checkLoginAndPasswordFields(loginTextField: UITextField, passwordTextField: UITextField, loginBtn: UIButton) {
            if ((loginTextField.text != "") && (passwordTextField.text != "")){
                loginBtn.isEnabled = true
                
            }
            else {
                loginBtn.isEnabled = false
            }
        }        
        
    }

