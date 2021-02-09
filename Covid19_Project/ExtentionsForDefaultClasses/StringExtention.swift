//
//  StringExtention.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 2/8/21.
//

import Foundation

extension String {
    func search(_ term: String) -> Bool {
        let lowercasedSelf = self.lowercased()
        let lowercasedTerm = term.lowercased()
        return lowercasedSelf.localizedCaseInsensitiveContains(lowercasedTerm)
    }
}
