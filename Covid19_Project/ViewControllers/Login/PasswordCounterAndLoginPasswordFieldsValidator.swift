//
//  PasswordCounterAndLoginPasswordFieldsValidator.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/20/21.
//

import Foundation
import UIKit

class PasswordCounterAndLoginPasswordFieldsValidator: FieldValidator {
    
    let fieldValidator: FieldValidator
    
    init(fieldValidator: FieldValidator) {
        self.fieldValidator = fieldValidator
    }
    
    var numberOfAtempts = 0
    
    func validateFields(loginTextFieldText: String, passwordTextFieldText: String) -> Bool {
        
        if numberOfAtempts < 6 {
            if fieldValidator.validateFields(loginTextFieldText: loginTextFieldText, passwordTextFieldText: passwordTextFieldText) == true{
                return true
            }
            else {
                numberOfAtempts += 1
                return false
            }
        }
        else {
            return false
        }
    }
}
