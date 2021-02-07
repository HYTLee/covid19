//
//  CaseViewModel.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 2/4/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol CaseViewModel {
    var cases: Observable<[Case]>? { get }
    
    func getDataForTableView(completion:@escaping () -> ())
}
