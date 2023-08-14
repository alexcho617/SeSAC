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
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    var media: Result?
    var nf = NumberFormatter()

    override func awakeFromNib() {
        super.awakeFromNib()
        nf.maximumSignificantDigits = 2
    }

    
    func configureView() {
        var genre = ""
        if let media{
            for id in media.genreIDS{
                genre += "#\(Genre.genreDictionary[id]!) "
            }
            dateLabel.text = media.releaseDate
            
            genreLabel.text = genre
            
            backdropImage.contentMode = .scaleAspectFill
            backdropImage.kf.setImage(with: URL.getEndPointImageURL(media.backdropPath))
            backdropImage.layer.cornerRadius = 12
            backdropImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            backdropImage.layer.masksToBounds = true
            backdropImage.clipsToBounds = true
            
            rating.text = "평점: " + (nf.string(for: media.voteAverage) ?? "0.0")
            
            title.text = media.title
            
            info.text = media.overview
        }
        
    }
    
}
