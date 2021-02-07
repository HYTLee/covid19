//
//  CasesViewModelImplementation.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 2/4/21.
//

import Foundation
import RxSwift
import RxCocoa

class CasesViewModelImplementation {
    
    private let casesDownloader = ContainerDependancies.container.resolve(CaseDownloader.self)
    var cases: Observable<[Case]>?
    var casesData: [Case]?    
    var refresh: PublishSubject<Void>?
    
    func getDataForTableView(completion:@escaping () -> ()){
        casesData = casesDownloader?.response
        casesDownloader?.getStatisticsFromApi { [self] in
            cases = Observable<[Case]>.create{ [self] observer -> Disposable in
                observer.onNext(casesDownloader?.response ?? [])
                observer.onCompleted()
                return Disposables.create()
                }
            completion()
        }
    
 }
    
}
