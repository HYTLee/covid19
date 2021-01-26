//
//  Covid19_ProjectTests.swift
//  Covid19_ProjectTests
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import XCTest
@testable import Covid19_Project

class Covid19_ProjectTests: XCTestCase {
    var fieldsValdator: PasswordCounterAndLoginPasswordFieldsValidator!

    override func setUpWithError() throws {
        fieldsValdator = PasswordCounterAndLoginPasswordFieldsValidator(fieldValidator: ComplexLoginAndPasswordFieldsValidator() as FieldValidator)
    }

    override func tearDownWithError() throws {
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
        let result = fieldsValdator.validateFields(loginTextFieldText: "test", passwordTextFieldText: "TestTest")
        XCTAssertFalse(result)
    }
    
}
