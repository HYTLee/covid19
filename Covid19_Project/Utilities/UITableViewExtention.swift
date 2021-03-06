//
//  UITableViewExtention.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 12/9/20.
//

import Foundation
import UIKit

extension UITableView {
    
    func deselectSelectedRow(animated: Bool){
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
    
    func isCellVisible(indexPath: IndexPath) -> Bool {
           guard let indexes = self.indexPathsForVisibleRows else {
               return false
           }
           return indexes.contains(indexPath)
       }
}
