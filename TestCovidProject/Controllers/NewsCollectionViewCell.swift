//
//  NewsCollectionViewCell.swift
//  TestCovidProject
//
//  Created by AP Yauheni Hramiashkevich on 11/2/20.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 20))
    let authorLabel = UILabel(frame: CGRect(x: 2, y: 115, width: 100, height: 20))
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
