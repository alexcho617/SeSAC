//
//  SearchTableViewCell.swift
//  MiniAppStore
//
//  Created by Alex Cho on 2023/11/07.
//

import UIKit
import RxSwift
import SnapKit
import Kingfisher
import Then

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    var disposeBag = DisposeBag()
    
    let appNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .label
    }
   
    let appIconImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let downloadButton = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.isUserInteractionEnabled = true
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 16
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(){
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appIconImageView)
        contentView.addSubview(downloadButton)
        
        appIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
            make.size.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(appIconImageView)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(8)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.centerY.equalTo(appIconImageView)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(32)
            make.width.equalTo(72)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
