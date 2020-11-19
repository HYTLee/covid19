//
//  NewsCell.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit

class NewsCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    
    override func setNeedsLayout() {
        layer.borderWidth = 5
        layer.masksToBounds = true
        layer.cornerRadius = 5
        
    }
    

    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundView = nil
    }
    
    
}
