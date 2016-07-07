//
//  PreviewTableViewCell.swift
//  AreYouSmiling
//
//  Created by Ahmed Abdelrahman on 7/6/16.
//  Copyright © 2016 Ahmed Abdelrahman. All rights reserved.
//

import UIKit

class PreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var emojiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
