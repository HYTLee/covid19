//
//  ImageDownloader.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/31/21.
//

import Foundation
import UIKit

class ImageForNewsesDownloader: Operation {
  
  let photoRecord: PhotoRecord
  
  init(_ photoRecord: PhotoRecord) {
    self.photoRecord = photoRecord
  }
  
  override func main() {

    if isCancelled {
      return
    }

    guard let imageData = try? Data(contentsOf: photoRecord.url) else { return }
    
    if isCancelled {
      return
    }
    
    if !imageData.isEmpty {
      photoRecord.image = UIImage(data:imageData)
      photoRecord.state = .downloaded
    } else {
      photoRecord.state = .failed
      photoRecord.image = UIImage(named: "Failed")
    }
  }
}
