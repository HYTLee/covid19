//
//  CheckImageForCache.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/17/21.
//

import Foundation
import UIKit

class CheckNewsImageForCache: ImageCacheChecker {
    
    private var task: URLSessionTask!
    
    func checkIfImageIsCached(url: URL,imageView: UIImageView){
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
    }

}
