//
//  Container.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/14/21.
//

import Foundation
import Swinject


class ContainerDependancies{
    
    static var container: Container! = {
        let container = Container()
        container.register(FieldValidator.self) { _ in PasswordCounterAndLoginPasswordFieldsValidator(fieldValidator: ComplexLoginAndPasswordFieldsValidator(), numberOfAttemptsSaver: SaverOfAttemptsToUserDafaults()) }
        container.register(ApplicationStyle.self, name: "Day") { _ in AppDayStyle() }
        container.register(ApplicationStyle.self, name: "Night") { _ in AppNightStyle() }
        container.register(StyleProvider.self) { _ in DayNightStyleProvider()}
        container.register(LoginViewModel.self) { _ in LogiViewModelImplementation()}
        container.register(CaseDownloader.self) { _ in CasesDataDownloader()}
  //     container.register(CaseViewModel.self) { _ in casesViewModelImplementation()}


        return container
    }()
    
    
}
