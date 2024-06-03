//
//  HotCityTableViewCell.swift
//  TravelMagazine
//
//  Created by t2023-m0032 on 6/1/24.
//

import UIKit

class HotCityTableViewCell: UITableViewCell {

    @IBOutlet var titleBetween: UILabel!
    @IBOutlet var titleLabel2: UILabel!
    @IBOutlet var uiView: UIView!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
