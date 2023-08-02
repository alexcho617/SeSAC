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
    
    //한번만 셋팅됨
    override func awakeFromNib() {
        super.awakeFromNib()
        mainTitleLabel.textColor = .label
        mainTitleLabel.font = .boldSystemFont(ofSize: 18)
        subTitleLabel.textColor = .secondaryLabel
    }
   
   
    
    func setCell(row: ToDo){
        mainTitleLabel.text = row.mainText
        subTitleLabel.text = row.subText
        backgroundColor = row.color
        checkBox.image = row.isDone ? UIImage(systemName: "drop.fill") : UIImage(systemName: "drop")
        if row.isLiked {
            likeButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            likeButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}

