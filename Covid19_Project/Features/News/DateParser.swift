//
//  DateParser.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 12/9/20.
//

import Foundation


class DateParser {
    
    private var date = Date()
    var dateString = String()
    
    
    func convertStringToDate(dateString: String)  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         date = dateFormatter.date(from:dateString)!
    }
    
    func convertDateToTimeStringShort()  {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        self.dateString = dateFormatter.string(from: date)
    }
    
}
