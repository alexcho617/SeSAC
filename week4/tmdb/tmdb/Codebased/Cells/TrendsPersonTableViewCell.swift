//
//  TrendsPersonTableViewCell.swift
//  tmdb
//
//  Created by Alex Cho on 2023/09/03.
//

import UIKit
import SnapKit

class TrendsPersonTableViewCell: BaseTableViewCell {
    let titleLabel = {
        let view = UILabel()
        view.text = "Person Cell"
        return view
    }()
    
    override func setView() {
        contentView.addSubview(titleLabel)
    }
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
