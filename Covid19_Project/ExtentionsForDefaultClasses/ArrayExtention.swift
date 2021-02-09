//
//  ArrayExtention.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 2/8/21.
//

import Foundation
import RxSwift
import RxCocoa

extension Array where Element == Case {
    func search(query: Event<String>) -> [Element] {
        return self.filter({
            guard let text = $0.country, let queryElement = query.element else { return false }
            return text.search(queryElement)
        })
    }
}
