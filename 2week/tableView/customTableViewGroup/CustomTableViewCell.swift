//
//  CustomTableViewCell.swift
//  tableView
//
//  Created by Alex Cho on 2023/07/28.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    @IBOutlet weak var backgroundImageView: UIView!
    
    @IBOutlet weak var checkBox: UIImageView!
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    
    func setCell(row: ToDo){
        mainTitleLabel.text = row.mainText
        subTitleLabel.text = row.subText
        
        checkBox.image = row.isDone ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        if row.isLiked {
            likeButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            likeButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}

