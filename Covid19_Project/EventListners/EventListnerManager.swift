//
//  LogoutListner.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/21/21.
//

import Foundation

class  EventListnerManager: EventListner{
    static var singleton = EventListnerManager()
    
    

    var listners = [EventListnerWithType]()
    
    func subscribe(listner: Listner, event: EventType) {
        var listnerWithType = EventListnerWithType(eventListner: listner, eventType: event)
        
        listners.append(listnerWithType)
    }
    
    func notify(event: EventType) {
        var listOfListnersToBeNotified = [EventListnerWithType]()
        for listner in listners {
            if listner.eventType == event {
                listOfListnersToBeNotified.append(listner)
            }
        }
        for listner in listOfListnersToBeNotified{
            listner.eventListner.update()
        }
    }
}
