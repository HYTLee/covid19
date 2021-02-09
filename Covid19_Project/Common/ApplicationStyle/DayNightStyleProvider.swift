//
//  AppStyleManager.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/19/21.
//

import Foundation
import UIKit
import Swinject

class DayNightStyleProvider: StyleProvider {
   
     let date = Date()
     let calendar = Calendar.current

    
    func checkForDayOrNight() -> ApplicationStyle {
            let hour = calendar.component(.hour, from: date)

            if hour <= 18 && hour >= 8 {
            let containerAppStyle = ContainerDependancies.container.resolve(ApplicationStyle.self, name: "Day")
            return containerAppStyle!
            
        } else{
            let containerAppStyle = ContainerDependancies.container.resolve(ApplicationStyle.self, name: "Night")
           return containerAppStyle!
        }
    }
    
}
