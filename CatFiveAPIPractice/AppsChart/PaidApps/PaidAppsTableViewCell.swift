//
//  PaidAppsTableViewCell.swift
//  CatFiveAPIPractice
//
//  Created by Shien on 2022/6/6.
//

import UIKit

class PaidAppsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var appDetailLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    
    @IBOutlet weak var numLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
