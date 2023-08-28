//
//  SearchCollectionViewCell.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/28.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell{
    
    var imageView = {
        let view = UIImageView()
        view.backgroundColor = .systemYellow
        view.contentMode = .scaleToFill
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(imageView)
        
    }
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(10)
        }
    }
    
}
