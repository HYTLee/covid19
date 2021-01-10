//
//  NewsImaggeView.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 11/19/20.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
class NewsImageView: UIImageView {
    var task: URLSessionTask!
    var queue = OperationQueue()

    func loadImage(url: URL)  {
        queue.maxConcurrentOperationCount = 1
        queue.addOperation { [self] in
            
            OperationQueue.main.addOperation({
                image = nil
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
                    self.image = newImage.image(alpha: 0.2)
                }
            }
            task.resume()
        }
       
       
    }
    
    
    func stopTask()  {
        queue.isSuspended = true
    }
    
    func continueTask()  {
        queue.isSuspended = false
    }
    
    
    
}

