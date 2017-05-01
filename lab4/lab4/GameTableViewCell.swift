//
//  GameTableViewCell.swift
//  Lab2
//
//  Created by Oleg Pyatko on 3/21/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet var gameNameLabel1: UILabel!
    
    @IBOutlet var previewImage: UIImageView!
    @IBOutlet var shortDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
