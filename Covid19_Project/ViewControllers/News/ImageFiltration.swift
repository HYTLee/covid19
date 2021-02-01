//
//  ImageFiltration.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/31/21.
//

import Foundation
import UIKit

class ImageFiltration: Operation {
  let photoRecord: PhotoRecord
  
  init(_ photoRecord: PhotoRecord) {
    self.photoRecord = photoRecord
  }
  
  override func main () {
    if isCancelled {
        return
    }
    
    func applyAlphaFilter(_ image: UIImage) -> UIImage? {
        guard let data = image.pngData() else { return nil }
      let inputImage = UIImage(data: data)
          
      if isCancelled {
        return nil
      }
          
        return inputImage?.image(alpha: 0.2)
    }


    guard self.photoRecord.state == .downloaded else {
      return
    }
      
    if let image = photoRecord.image,
       let filteredImage = applyAlphaFilter(image) {
      photoRecord.image = filteredImage
      photoRecord.state = .filtered
    }
  }
    
}


