//
//  SearchCell.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/21.
//

import UIKit

class SearchCell: UICollectionViewCell {
    var imageView = UIImageView()
    var label = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        
        label.text = "Test Cell"
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
