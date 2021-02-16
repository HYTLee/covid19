//
//  CountSaver.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/26/21.
//

import Foundation

protocol NumberOfAttemptsSaver {
    
    
    func saveAttempts(numberOfAtempts: Int)
    func checkForCurrentAttemptsCount() -> Int
}
