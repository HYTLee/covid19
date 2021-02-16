//
//  PhotoRecord.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/27/21.
//

import Foundation
import UIKit

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
