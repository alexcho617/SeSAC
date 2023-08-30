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
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    let rightSearchButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemMint
        return view
    }()
    
    let leftSearchProtocolButton = {
        let view = UIButton()
        view.setTitle("Prtc", for: .normal)
        view.backgroundColor = .systemCyan
        return view
    }()
    
    let titleButton = {
        let view = UIButton()
        view.backgroundColor = .systemBlue
        view.setTitle("오늘의 사진", for: .normal)
        return view
    }()
    
    let labelButton = {
        let view = UIButton()
        view.backgroundColor = .systemBlue
        view.setTitle("오늘의 내용", for: .normal)
        return view
    }()
    
    let dateButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.tintColor = .white
        view.setTitle(DateFormatter.today(), for: .normal)
        return view
    }()
    
    
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        rightSearchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
        
        leftSearchProtocolButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.leading.equalTo(photoImageView)
        }
        
        dateButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            
        }
        
        titleButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.equalTo(dateButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            
        }
        
        labelButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            
        }
    }
    
    override func configureView() {
        addSubview(photoImageView) //자기 자신임
        addSubview(rightSearchButton)
        addSubview(dateButton)
        addSubview(leftSearchProtocolButton)
        addSubview(titleButton)
        addSubview(labelButton)
    }
    
}
