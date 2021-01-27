//
//  MockNumberOfAttemptsSaver.swift
//  Covid19_ProjectTests
//
//  Created by AP Yauheni Hramiashkevich on 1/27/21.
//

import Foundation
@testable import Covid19_Project


class MockNumberOfAttemptsSaver: NumberOfAttemptsSaver {
    var numberOfAtempts: Int = 0
    
    func saveAttempts() {
    }
    
    func checkForCurrentAttemptsCount() -> Int {
        return self.numberOfAtempts
    }
    
    
}
