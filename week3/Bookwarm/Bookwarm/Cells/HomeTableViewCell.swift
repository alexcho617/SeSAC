//
//  HomeTableViewCell.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/09/04.
//

import UIKit
import SnapKit
import Kingfisher
class HomeTableViewCell: UITableViewCell {
    static let identifier = String(describing: HomeTableViewCell.self)
    
    var titleLabel = {
        let view = UILabel()
        return view
    }()
    
    var coverImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemMint
        return view
    }()
    
    func setView(){
        self.backgroundColor = .gray
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(100)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView)
            make.leading.equalTo(coverImageView.snp.trailing)
            make.trailing.equalToSuperview()
        }
    }
    
    
    

}
