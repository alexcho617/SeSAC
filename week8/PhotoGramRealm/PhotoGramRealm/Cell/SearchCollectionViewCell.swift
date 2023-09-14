//
//  SearchCollectionViewCell.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/04.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = PhotoImageView(frame: .zero)
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        return view
    }()
      
    override func configure() {
        //MARK: BaseCollectionViewCell의 init에서 configre(), setConstraint() 호출 꼭 필요
//        print("DEBUG",#file, #function ,#line)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    override func setConstraints() {
//        print("DEBUG",#file, #function ,#line)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(imageView)
        }
    }
}
