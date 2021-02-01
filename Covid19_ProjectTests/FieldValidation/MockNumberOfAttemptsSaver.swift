//
//  MockNumberOfAttemptsSaver.swift
//  Covid19_ProjectTests
//
//  Created by AP Yauheni Hramiashkevich on 1/27/21.
//

import Foundation
@testable import Covid19_Project


class MockNumberOfAttemptsSaver: NumberOfAttemptsSaver {
    
    var attempts = 0

    func saveAttempts(numberOfAtempts: Int) {
        attempts += 1
    }
    

    
    func checkForCurrentAttemptsCount() -> Int {
        return attempts
    }
    

}
