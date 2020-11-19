//
//  NewsImaggeView.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 11/19/20.
//

import UIKit

class NewsImaggeView: UIImageView {
    var task: URLSessionTask!

    func loadImage(url: URL)  {
        image = nil
        
        if let task = task{
        task.cancel()
        }
        
         task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else {
                print("could not find image")
                return
            }
            DispatchQueue.main.async {
                self.image = newImage.image(alpha: 0.2)
            }
        }
        
        task.resume()
    }
}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
