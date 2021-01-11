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
    
    lazy var queue: OperationQueue = {
      var downloadQueue = OperationQueue()
      downloadQueue.name = "Download queue"
      downloadQueue.maxConcurrentOperationCount = 1
      return downloadQueue
    }()

    func loadImage(url: URL)  {
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
    
    func startDownload(url: URL) {
        queue.addOperation { [self] in
            loadImage(url: url)
        }
    }
    
    
    func stopTask()  {
        queue.isSuspended = true
    }
    
    func continueTask()  {
        queue.isSuspended = false
    }
    
    
    
}

