//
//  LibraryCollectionViewCell.swift
//  SearchExample
//
//  Created by jack on 2023/08/04.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    
    static let identifier = "LibraryCollectionViewCell"
    
    func configureCell(data: Movie) {
        
        backgroundColor = .lightGray
        layer.cornerRadius = 15
        
        titleLabel.text = data.title
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        rateLabel.text = "\(data.rate)"
        rateLabel.textColor = .white
        rateLabel.font = .systemFont(ofSize: 12)
        
        titleImageView.image = UIImage(named: data.title)
        
        if data.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
}
