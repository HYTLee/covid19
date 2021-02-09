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
    @IBOutlet weak var newsImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
       super.awakeFromNib()
        backgroundView = UIView()
        layer.borderWidth = 5
        layer.masksToBounds = true
        layer.cornerRadius = 5
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newsImageView.image = nil
    }
}

