//
//  TestPasswordCounter.swift
//  Covid19_ProjectTests
//
//  Created by AP Yauheni Hramiashkevich on 1/26/21.
//

import Foundation
import XCTest
@testable import Covid19_Project

class TestPassowrdCounter: XCTestCase {
    var fieldsValdator: PasswordCounterAndLoginPasswordFieldsValidator!
    var mockComplexLoginAndPasswordFieldsValidator: MockComplexLoginAndPasswordFieldsValidator!
    var mockNumberOfAttemptsSaver: MockNumberOfAttemptsSaver!
    
    
    override func setUpWithError() throws {
        mockComplexLoginAndPasswordFieldsValidator = MockComplexLoginAndPasswordFieldsValidator()
        mockNumberOfAttemptsSaver = MockNumberOfAttemptsSaver()
        fieldsValdator = PasswordCounterAndLoginPasswordFieldsValidator(fieldValidator: mockComplexLoginAndPasswordFieldsValidator, numberOfAttemptsSaver: mockNumberOfAttemptsSaver)
    }

    override func tearDownWithError() throws {
        mockComplexLoginAndPasswordFieldsValidator.validateResult = false
        mockNumberOfAttemptsSaver.numberOfAtempts = 0
    }

    func testUserEnteredWrongPasswordFiveTimes() throws {
        for _ in 1...5{
            let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTes")
            XCTAssertFalse(result)
        }
    }
    
    func testUserEnteredWrongPasswordFourTimesAndThenEnterredRightPassword() throws {
        for _ in 1...5{
            let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTes")
            XCTAssertFalse(result)
        }
        mockComplexLoginAndPasswordFieldsValidator.validateResult = true
        let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTest")
        XCTAssertTrue(result)
    }
    
    func testUserEnteredWrongPasswordFiveTimesAndThenEnteredRightPassword() throws {
        for _ in 1...6{
            let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTes")
            XCTAssertFalse(result)
        }
        mockComplexLoginAndPasswordFieldsValidator.validateResult = true
        let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTest")
        XCTAssertFalse(result)
    }
    
}
