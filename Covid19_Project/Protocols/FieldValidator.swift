//
//  FieldValidator.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/14/21.
//

import Foundation


protocol FieldValidator {
    
    func validateFields(loginTextFieldText: String, passwordTextFieldText: String) -> Bool
    
}
