//
//  CountryTableCell.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/31/20.
//

import UIKit

class CountryTableCell: UITableViewCell {
    
    @IBOutlet weak var countryLable: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deadLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
