//
//  MockComplexLoginAndPasswordFieldsValidator.swift
//  Covid19_ProjectTests
//
//  Created by AP Yauheni Hramiashkevich on 1/26/21.
//

import Foundation
@testable import Covid19_Project

class MockComplexLoginAndPasswordFieldsValidator: FieldValidator{
    
    var validateResult = false
    
    func validateFields(loginTextFieldText: String, passwordTextFieldText: String) -> Bool {
        return validateResult
    }
    
    
}
	
