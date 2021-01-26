//
//  Covid19_ProjectTests.swift
//  Covid19_ProjectTests
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import XCTest
@testable import Covid19_Project

class TestComplexFieldsValidation: XCTestCase {
    var fieldsValdator: ComplexLoginAndPasswordFieldsValidator!

    override func setUpWithError() throws {
        fieldsValdator = ComplexLoginAndPasswordFieldsValidator()
    }

   

    func testFullFilledLoginAndPasswordFiedlsCorrectly() throws {
      let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTest")
        assert(result)
    }
    
    func testLoginFieldDidntFullFilled() throws {
        let result = fieldsValdator.validateFields(loginTextFieldText: "", passwordTextFieldText: "TestTest")
        XCTAssertFalse(result)
    }
    
    func testPasswordFieldDidntFullFilled() throws {
        let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "")
        XCTAssertFalse(result)
    }
    
    func testPasswordFieldDidntContainUpperCase() throws {
        let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "testtest")
        XCTAssertFalse(result)
    }
    
    func testPasswordFieldDidntContainLowerCase() throws {
        let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TESTTEST")
        XCTAssertFalse(result)
    }
    
    func testPasswordFieldDidntContainEnoughCharacters() throws {
        let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTes")
        XCTAssertFalse(result)
    }
    
    
}
