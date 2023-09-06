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
    
    var infoLabel = {
        let view = UILabel()
        return view
    }()
    
    var coverImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemMint
        return view
    }()
    
    func setView(){
        self.backgroundColor = .secondarySystemBackground
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(coverImageView)
        self.contentView.addSubview(infoLabel)
        coverImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(100)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView)
            make.leading.equalTo(coverImageView.snp.trailing)
            make.trailing.equalToSuperview()
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(coverImageView.snp.trailing)
            make.trailing.equalToSuperview()
        }
    }
    
    
    

}
