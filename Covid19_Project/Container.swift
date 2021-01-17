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
        container.register(FieldValidator.self) { _ in ComplexLoginAndPasswordFieldsValidator() }
        container.register(ImageDownloader.self) { _ in NewsImageDownloader()}
        return container
    }()
    
    
}
