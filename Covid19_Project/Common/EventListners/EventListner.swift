//
//  EventListne.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/21/21.
//

import Foundation

protocol EventListner{

    func subscribe(listner:Listner, event: EventType, eventId: Int)
    func notify(event: EventType)
}


