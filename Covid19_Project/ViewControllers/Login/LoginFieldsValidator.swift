//
//  LoginFieldsValidator.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/12/21.
//

import Foundation
import UIKit


class LoginFieldsValidator {
    
    func checkLoginAndPasswordFields(loginTextFieldText: String, passwordTextFieldText: String) -> Bool {
            if ((loginTextFieldText != "") && (passwordTextFieldText != "")){
                return true
            }
            else {
                return false
            }
        }        
        
    }

