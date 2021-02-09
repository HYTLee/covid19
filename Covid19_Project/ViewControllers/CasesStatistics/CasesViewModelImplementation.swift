//
//  CasesViewModelImplementation.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 2/4/21.
//

import Foundation
import RxSwift
import RxCocoa

class CasesViewModelImplementation: CaseViewModel {
    
    private let casesDownloader = ContainerDependancies.container.resolve(CaseDownloader.self)
    var cases: Observable<[Case]>?
    var filteredCases: Observable<[Case]>?
    
    func getDataForTableView(completion:@escaping () -> ()){
        casesDownloader?.getStatisticsFromApi { [self] in
            cases = Observable<[Case]>.create{ [self] observer -> Disposable in
                observer.onNext(casesDownloader?.response ?? [])
                observer.onCompleted()
                return Disposables.create()
                }
            completion()
        }
 }
    func filterSearchText(query: Event<ControlProperty<String>.Element>, completion:() -> ())  {
        let filteredText = casesDownloader?.response.search(query: query)
        cases = Observable<[Case]>.just(filteredText ?? [])
        completion()
    }
    
}
