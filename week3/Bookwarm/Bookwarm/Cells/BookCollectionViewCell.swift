//
//  BookCollectionViewCell.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit
import Kingfisher
class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var cellRatingLabel: UILabel!
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    
    override func awakeFromNib() {
       //set
    }
    func setCell(row book: Book){
        cellRatingLabel?.text = book.authors
        cellLabel?.text = book.title
        cellImageView.kf.setImage(with: URL(string: book.thumbnail))
        likeButton.setImage(book.isLiked == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        
    }
}
