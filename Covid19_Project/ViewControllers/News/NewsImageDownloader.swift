//
//  ImageDownloader.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/15/21.
//

import Foundation
import UIKit

class NewsImageDownloader {
    private var task: URLSessionTask!
    
    func loadImage(url: URL, imageView: UIImageView)  {
            OperationQueue.main.addOperation({
                imageView.image = nil
                   })
            
            if let task = task{
            task.cancel()
            }
            
            if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
                OperationQueue.main.addOperation({
                    imageView.image = imageFromCache.image(alpha: 0.2)
                       })
                return
            }
            
             task = URLSession.shared.dataTask(with: url){ (data, response, error) in
                guard
                    let data = data,
                    let newImage = UIImage(data: data)
                else {
                    print("could not find image")
                    return
                }
                imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)

                DispatchQueue.main.async {
                    imageView.image = newImage.image(alpha: 0.2)
                }
            }
            task.resume()
    }
    
    
    
}
