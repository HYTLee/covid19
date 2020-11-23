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
    
    var imageIV = NewsImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

    
    override func setNeedsLayout() {
        layer.borderWidth = 5
        layer.masksToBounds = true
        layer.cornerRadius = 5
        backgroundView = UIView()
        backgroundView?.addSubview(imageIV)
       
    }
    

    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundView = nil
    }
}

