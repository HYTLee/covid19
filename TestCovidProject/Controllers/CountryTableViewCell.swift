//
//  CountryTableViewCell.swift
//  TestCovidProject
//
//  Created by AP Yauheni Hramiashkevich on 11/2/20.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    let caseLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 10, height: 10))

    override func awakeFromNib() {
        super.awakeFromNib()
        setCaseLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    func setCaseLabel() {
        self.addSubview(caseLabel)
        caseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let caseLabelTopConstr = NSLayoutConstraint(
            item: caseLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.contentView.topAnchor,
            attribute: .top,
            multiplier: 1,
            constant: 5)
        
        let caseLabelLeftConstr = NSLayoutConstraint(
            item: caseLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.contentView.leadingAnchor,
            attribute: .leading,
            multiplier: 1,
            constant: 5)
            
        let caseLabelRightConstr = NSLayoutConstraint(
            item: caseLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self.contentView.trailingAnchor,
            attribute: .trailing,
            multiplier: 1,
            constant: 5)
        
        let caseLabelHeightConstr = NSLayoutConstraint(
            item: caseLabel,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 30)
        
        self.addConstraints([caseLabelTopConstr, caseLabelLeftConstr, caseLabelRightConstr, caseLabelHeightConstr])
            
    }

}
