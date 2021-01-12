//
//  LoginTextField.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/12/21.
//

import Foundation
import UIKit

class LoginTextField: UITextField {
    
    override func borderRect(forBounds bounds: CGRect) -> CGRect {
        textColor = .green
        return bounds.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
}
