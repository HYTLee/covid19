//
//  NewsImaggeView.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 11/19/20.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
class NewsImageView: UIImageView {
    
    private let imageDownloader = NewsImageDownloader()
    
    

    func setImageToImageView(url: URL)  {
        imageDownloader.loadImage(url: url, imageView: self)
    }
    
  
    
  
    
    
    
    
}

