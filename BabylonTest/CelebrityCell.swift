//
//  CelebrityCell.swift
//  BabylonTest
//
//  Created by Abid Ghani on 10/02/2016.
//  Copyright © 2016 BOSS Computing. All rights reserved.
//

import UIKit

class CelebrityCell: UITableViewCell {

    @IBOutlet weak var celebrityNameLabel: UILabel!
    
    @IBOutlet weak var celebrityPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Some code to make the avatar a circle.
        self.celebrityPhoto.layer.cornerRadius = self.celebrityPhoto.frame.size.width/2
        self.celebrityPhoto?.layer.masksToBounds = true
        self.celebrityPhoto.clipsToBounds = true
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
