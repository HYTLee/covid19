//
//  SaverOfAttemptsToKeyChain.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/26/21.
//

import Foundation


class SaverOfAttemptsToUserDafaults: NumberOfAttemptsSaver {
    
    let userNumberOfAtemptsKey = "NumberOfAtemptsKey"
    var numberOfAtempts = 0

    func checkForCurrentAttemptsCount() -> Int {
        let numberOfAtemptsFromUserDefaults =  UserDefaults.standard.integer(forKey: userNumberOfAtemptsKey)

        return numberOfAtemptsFromUserDefaults
    }
    
    func saveAttempts() {
        UserDefaults.standard.string(forKey: userNumberOfAtemptsKey)
        UserDefaults.standard.setValue(numberOfAtempts, forKey: userNumberOfAtemptsKey)
    }
    
    
    
}
