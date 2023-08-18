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
    var credits: Credits?
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
            
            //MARK: 원래 여기서 배우들을 보여줘야하나 현재 안쓰고 있음. 이것때문에 트렌드 안에 크레딧까지 콜백으로 너은건데 안쓰는중
            info.text = media.overview
        }
        
    }
    
}
