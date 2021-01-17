//
//  CacheChecker.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/17/21.
//

import Foundation
import UIKit

protocol ImageCacheChecker {
    
    func checkIfImageIsCached(url: URL,imageView: UIImageView)
    
}
