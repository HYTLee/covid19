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
    @IBOutlet weak var timeLabel: UILabel!

    
    var imageIV = NewsImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    
    override func awakeFromNib() {
       super.awakeFromNib()
        backgroundView = UIView()
        backgroundView?.addSubview(imageIV)
    }
    
    override func setNeedsLayout() {
        layer.borderWidth = 5
        layer.masksToBounds = true
        layer.cornerRadius = 5
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

