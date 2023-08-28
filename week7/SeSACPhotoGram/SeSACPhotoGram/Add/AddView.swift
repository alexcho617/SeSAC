//
//  AddView.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/28.
//

import UIKit

class AddView: BaseView{
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let searchButon = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButon.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
    }
    
    override func configureView() {
        addSubview(photoImageView) //자기 자신임
        addSubview(searchButon)
    }
    
}
