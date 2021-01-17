//
//  ImageDownloader.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/15/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class NewsImageDownloader: ImageDownloader {
    
    private var task: URLSessionTask!
    
    func loadImage(url: URL, imageView: UIImageView, completion: @escaping (_ newImage: UIImage) -> ())  {
            
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
                    completion(newImage)
                }
            }
            task.resume()
    }
    
    
    
}
