//
//  TrendsTableViewCell.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/13.
//

import UIKit
import Kingfisher
class TrendsTableViewCell: UITableViewCell {

    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    @IBOutlet weak var detailButton: UIButton!
    
    var media: Media?
    var nf = NumberFormatter()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nf.maximumSignificantDigits = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureView() {
        if let media{
            backdropImage.contentMode = .scaleAspectFill
            backdropImage.kf.setImage(with: URL(string: media.backdropImageURL))
            rating.text = "평점: " + (nf.string(for: media.vote_average) ?? "0.0")
            title.text = media.title
            info.text = media.release_date
        }
        
    }
    
}
