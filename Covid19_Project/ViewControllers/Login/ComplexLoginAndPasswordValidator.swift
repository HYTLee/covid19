//
//  LoginFieldsValidator.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/12/21.
//

import Foundation
import UIKit


class ComplexLoginAndPasswordFieldsValidator: FieldValidator {
    
    func validateFields(loginTextFieldText: String, passwordTextFieldText: String) -> Bool {
        if (loginTextFieldText != "") && (passwordTextFieldText != "") && self.passwordValidation(passwordTextFieldText: passwordTextFieldText) {
                return true
            }
            else {
                return false
            }
        }
    
   private func passwordValidation(passwordTextFieldText: String) -> Bool {
        let passwordCharactesCount = passwordTextFieldText.count
        if passwordCharactesCount > 7 && validateUpperAndLowerCases(string: passwordTextFieldText) {
            return true
        }
        else{
            return false
        }
    }
    
  private func validateUpperAndLowerCases(string: String) -> Bool {
        let lowercase = CharacterSet.lowercaseLetters
        let uppercase = CharacterSet.uppercaseLetters

        let lowercaseRange = string.rangeOfCharacter(from: lowercase)
        let uppercaseRange = string.rangeOfCharacter(from: uppercase)

        return lowercaseRange != nil && uppercaseRange != nil
    }
}

