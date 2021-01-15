//
//  OperationQueueController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/15/21.
//

import Foundation
import UIKit

class OperationQueueController {
    
    lazy var queue: OperationQueue = {
      var downloadQueue = OperationQueue()
      downloadQueue.name = "Download queue"
      downloadQueue.maxConcurrentOperationCount = 1
      return downloadQueue
    }()

    func stopTask()  {
        queue.isSuspended = true
    }
    
    func continueTask()  {
        queue.isSuspended = false
    }
    
}
