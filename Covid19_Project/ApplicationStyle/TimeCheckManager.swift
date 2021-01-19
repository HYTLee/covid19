//
//  AppStyleManager.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/19/21.
//

import Foundation
import UIKit
import Swinject

class TimeCheckManager: TimeCheck {
   
     let date = Date()
     let calendar = Calendar.current

    
    
    func checkForDayOrNight() -> Bool {
        let hour = calendar.component(.hour, from: date)

        if hour <= 18 && hour >= 8 {
             return true
        } else{
           return false
        }
    }
    
}
