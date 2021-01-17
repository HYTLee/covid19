//
//  NewsImaggeView.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 11/19/20.
//

import UIKit

class NewsImageView: UIImageView {
    
    private let containerImageDownloader = ContainerDependancies.container.resolve(ImageDownloader.self)
    private var task: URLSessionTask!


    func setImageToImageView(url: URL)  {
        OperationQueue.main.addOperation({
            self.image = nil
               })
        
        if let task = task{
        task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            OperationQueue.main.addOperation({
                self.image = imageFromCache.image(alpha: 0.2)
                   })
            return
        }
        containerImageDownloader?.loadImage(url: url, imageView: self, completion: { (newsImage) in
            self.image = newsImage.image(alpha: 0.2)

        })
    }
    
  
    
  
    
    
    
    
}

