//
//  CastTableViewCell.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/15.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
