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
    var mock = MockComplexLoginAndPasswordFieldsValidator()

    
    
    override func setUpWithError() throws {
        fieldsValdator = PasswordCounterAndLoginPasswordFieldsValidator(fieldValidator: mock)
    }

    override func tearDownWithError() throws {
        mock.validateResult = false
    }

    func testUserEnteredWrongPasswordFiveTimes() throws {
        for _ in 1...5{
            let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTes")
            XCTAssertFalse(result)
        }
    }
    
    func testUserEnteredWrongPasswordFourTimesAndThenEnterredRightPassword() throws {
        let userNumberOfAtemptsKey = "NumberOfAtemptsKey"
        UserDefaults.standard.setValue( 0, forKey: userNumberOfAtemptsKey)
        for _ in 1...3{
            let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTes")
            XCTAssertFalse(result)
        }
        mock.validateResult = true
        let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTest")
        XCTAssertTrue(result)
    }
    
    func testUserEnteredWrongPasswordFiveTimesAndThenEnteredRightPassword() throws {
        let userNumberOfAtemptsKey = "NumberOfAtemptsKey"
        UserDefaults.standard.setValue( 0, forKey: userNumberOfAtemptsKey)
        for _ in 1...6{
            let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTes")
            XCTAssertFalse(result)
        }
        mock.validateResult = true
        let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTest")
        XCTAssertFalse(result)
    }
    
}
