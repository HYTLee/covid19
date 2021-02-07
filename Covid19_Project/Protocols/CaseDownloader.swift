//
//  CaseDownloader.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 2/5/21.
//

import Foundation

protocol CaseDownloader {
    
    var response: [Case] { get }
    func getStatisticsFromApi(completion:@escaping () -> ())
}
