//
//  UICollectionViewExtention.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/10/21.
//

import Foundation
import UIKit

extension UICollectionView {
  var visibleCurrentCellIndexPath: IndexPath? {
    for cell in self.visibleCells {
      let indexPath = self.indexPath(for: cell)
      return indexPath
    }
    
    return nil
  }
}
