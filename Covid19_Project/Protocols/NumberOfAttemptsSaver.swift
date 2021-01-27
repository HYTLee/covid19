//
//  CountSaver.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/26/21.
//

import Foundation

protocol NumberOfAttemptsSaver {
    
    var numberOfAtempts: Int { get set }
    
    func saveAttempts()
    
    func checkForCurrentAttemptsCount() -> Int
}
