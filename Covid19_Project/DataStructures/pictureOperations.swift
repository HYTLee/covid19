//
//  pictureOperations.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 11/15/20.
//

import Foundation
import UIKit

// This enum contains all the possible states a photo record can be in
enum PhotoRecordState {
  case new, downloaded, failed
}

class PhotoRecord {
  let name: String
  let url: URL
  var state = PhotoRecordState.new
  var image = UIImage(named: "Placeholder")
  
  init(name:String, url:URL) {
    self.name = name
    self.url = url
  }
}
