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
    
    let userNumberOfAtemptsKey = "NumberOfAtemptsKey"

    
    init(fieldValidator: FieldValidator) {
        self.fieldValidator = fieldValidator
    }
    
    var numberOfAtempts = 0
    
    func validateFields(loginTextFieldText: String, passwordTextFieldText: String) -> Bool {
        let numberOfAtemptsFromUserDefaults =  UserDefaults.standard.integer(forKey: userNumberOfAtemptsKey)
        print(numberOfAtemptsFromUserDefaults)
        if numberOfAtemptsFromUserDefaults < 6 {
            if fieldValidator.validateFields(loginTextFieldText: loginTextFieldText, passwordTextFieldText: passwordTextFieldText) == true{
                return true
            }
            else {
                self.numberOfAtempts += 1
                self.saveNumberOfAtemptsToUserDefaults()
                return false
            }
        }
        else {
            self.timerForNumberOfAtemptsReset()
            return false
        }
    }
    
    
    func saveNumberOfAtemptsToUserDefaults()  {
        UserDefaults.standard.string(forKey: userNumberOfAtemptsKey)
        UserDefaults.standard.setValue(numberOfAtempts, forKey: userNumberOfAtemptsKey)
    }
    
    
    func timerForNumberOfAtemptsReset()  {
        Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
    }
    
    
    @objc func fireTimer(){
        self.numberOfAtempts = 0
        self.saveNumberOfAtemptsToUserDefaults()
    }
}