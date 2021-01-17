//
//  NewsImaggeView.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 11/19/20.
//

import UIKit

class NewsImageView: UIImageView {
    
    private let containerImageDownloader = ContainerDependancies.container.resolve(ImageDownloader.self)
    private let containerImageCacheChecker = ContainerDependancies.container.resolve(CheckNewsImageForCache.self)


    func setImageToImageView(url: URL)  {
        containerImageCacheChecker?.checkIfImageIsCached(url: url, imageView: self)
        containerImageDownloader?.loadImage(url: url, imageView: self, completion: { (newsImage) in
            self.image = newsImage.image(alpha: 0.2)

        })
    }
    
  
    
  
    
    
    
    
}

