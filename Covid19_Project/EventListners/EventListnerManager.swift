//
//  LogoutListner.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/21/21.
//

import Foundation

class  EventListnerManager: EventListner{
    static var singleton = EventListnerManager()
    
    private var listners = [Listners]()
    
    func subscribe(listner: Listners) {
        listners.append(listner)
    }
    
    func notify() {
        for listner in listners{
            listner.update()
        }
    }
    
    
    
    
   
}
