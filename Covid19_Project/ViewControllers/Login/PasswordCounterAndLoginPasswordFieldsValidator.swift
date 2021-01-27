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
    var numberOfAttemptsSaver: NumberOfAttemptsSaver
    
    init(fieldValidator: FieldValidator, numberOfAttemptsSaver: NumberOfAttemptsSaver) {
        self.fieldValidator = fieldValidator
        self.numberOfAttemptsSaver = numberOfAttemptsSaver
    }
    

    
    func validateFields(loginTextFieldText: String, passwordTextFieldText: String) -> Bool {
        let numberOfAtemptsFromUserDefaults: Int =  numberOfAttemptsSaver.checkForCurrentAttemptsCount()
        print(numberOfAtemptsFromUserDefaults)
        if numberOfAtemptsFromUserDefaults < 6 {
            if fieldValidator.validateFields(loginTextFieldText: loginTextFieldText, passwordTextFieldText: passwordTextFieldText) == true{
                return true
            }
            else {
                numberOfAttemptsSaver.numberOfAtempts += 1
                numberOfAttemptsSaver.saveAttempts()
                return false
            }
        }
        else {
            self.timerForNumberOfAtemptsReset()
            return false
        }
    }
    
    
    func timerForNumberOfAtemptsReset()  {
        Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
    }
    
    
    @objc func fireTimer(){
        numberOfAttemptsSaver.numberOfAtempts = 0
        numberOfAttemptsSaver.saveAttempts()
    }
}
