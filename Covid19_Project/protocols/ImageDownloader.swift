//
//  ImageDownloader.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/17/21.
//

import Foundation
import UIKit

protocol ImageDownloader {
    
    func loadImage(url: URL, imageView: UIImageView,completion: @escaping (_ newImage: UIImage) -> ())
    
}
