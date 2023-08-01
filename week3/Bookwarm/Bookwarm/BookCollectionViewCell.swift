//
//  BookCollectionViewCell.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var cellRatingLabel: UILabel!
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    func setCell(row cell: Movie){
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1

        backgroundColor = UIColor(cgColor: .init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: CGFloat.random(in: 0...1)))
        
        cellLabel?.text = cell.title
        let fs = formatter.string(for: cell.rate)
        cellRatingLabel?.text = fs
        
        let image = UIImage(named: cell.title) ?? UIImage(systemName: "picture")
        
        cellImageView.image = image
        likeButton.setImage(cell.isLiked == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        
    }
}
