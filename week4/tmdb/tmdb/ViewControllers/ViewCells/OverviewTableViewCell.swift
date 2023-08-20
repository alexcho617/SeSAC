//
//  OverviewTableViewCell.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/15.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        overviewLabel.text = "Placeholder from awakfrom nib"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
