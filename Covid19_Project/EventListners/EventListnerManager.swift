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
    
    func subscribe(listner: Listner, event: EventType, eventId: Int) {
        let listnerWithType = EventListnerWithType(eventListner: listner, eventType: event, eventId: eventId)
        listners.append(listnerWithType)
    }
    
    func unsubscribe(eventId: Int)  {
        for listner in listners {
            if listner.eventId == eventId {
                let eventIdentifier = eventId
                if let i = listners.firstIndex(where: { $0.eventId == eventIdentifier}) {
                    listners.remove(at: i)
                }
                }
        
        }
    }
    

    
    func notify(event: EventType) {
        for listner in listners {
            if listner.eventType == event {
                listner.eventListner.update()
            }
        }
    }
}
