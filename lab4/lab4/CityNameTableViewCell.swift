//
//  CityNameTableViewCell.swift
//  lab3
//
//  Created by Oleg Pyatko on 4/18/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import UIKit

class CityNameTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
