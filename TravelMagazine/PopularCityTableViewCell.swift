//
//  PopularCityTableViewCell.swift
//  TravelMagazine
//
//  Created by t2023-m0032 on 5/28/24.
//

import UIKit

class PopularCityTableViewCell: UITableViewCell {

    @IBOutlet var likeButton: UIButton!
    @IBOutlet var uiImageView: UIImageView!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
