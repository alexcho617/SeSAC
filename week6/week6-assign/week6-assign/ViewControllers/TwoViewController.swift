//
//  TwoViewController.swift
//  week6-assign
//
//  Created by Alex Cho on 2023/08/22.
//

import UIKit
import SnapKit

class TwoViewController: UIViewController {
    private let buttonSizeSmall = 32
    private let buttonSizeLarge = 60
    private let padding = 16
    
    private enum ButtonIcons: String{
        case xmark =  "xmark"
        case gift = "gift.circle"
        case check = "flag.circle"
        case setting = "gearshape.circle"
        case chat = "message"
        case edit = "pencil"
        case quote = "quote.closing"
    }
    
    //1 declare
    let xButton = getButton(iconName: ButtonIcons.xmark.rawValue)
    let giftButton = getButton(iconName: ButtonIcons.gift.rawValue)
    let checkButton = getButton(iconName: ButtonIcons.check.rawValue)
    let settingButton = getButton(iconName: ButtonIcons.setting.rawValue)
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.image = UIImage(systemName: "person")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let messageLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Alex"
        return label
    }()
    
    let chatButton = getButton(iconName: ButtonIcons.chat.rawValue)
    let editButton = getButton(iconName: ButtonIcons.edit.rawValue)
    let storyButton = getButton(iconName: ButtonIcons.quote.rawValue)
    
    let chatLabel = getLabel(text: "나와의 채팅")
    let editLabel = getLabel(text: "프로필 편집")
    let storyLabel = getLabel(text: "카카오스토리")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        //2 add
        view.addSubview(xButton)
        view.addSubview(giftButton)
        view.addSubview(checkButton)
        view.addSubview(settingButton)
        
        view.addSubview(imageView)
        
        view.addSubview(messageLabel)
        
        view.addSubview(chatButton)
        view.addSubview(editButton)
        view.addSubview(storyButton)
        
        view.addSubview(chatLabel)
        view.addSubview(editLabel)
        view.addSubview(storyLabel)
        
        //3 constraints
        configureConstraints()

    }
    

    
    private func configureConstraints(){

        
        //buttons
        xButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(padding)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(padding)
            make.size.equalTo(buttonSizeSmall)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(padding)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-padding)
            make.size.equalTo(buttonSizeSmall)

        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(padding)
            make.trailing.equalTo(settingButton.snp.leading)
            make.size.equalTo(buttonSizeSmall)

        }
        
        giftButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(padding)
            make.trailing.equalTo(checkButton.snp.leading)
            make.size.equalTo(buttonSizeSmall)

        }
        
        //image
        imageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).multipliedBy(0.7)
        }
        
        //label
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(padding)
        }
        
        //lower buttons
        
        //middle
        editButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(buttonSizeLarge)
            make.top.equalTo(messageLabel.snp.bottom).offset(padding)
        }
        editLabel.snp.makeConstraints { make in
            make.centerX.equalTo(editButton.snp.centerX)
            make.centerY.equalTo(editButton.snp.bottom)
        }
        
        //left
        chatButton.snp.makeConstraints { make in
            make.centerX.equalTo(editButton.snp.centerX).offset(-view.frame.width/4)
            make.centerY.equalTo(editButton.snp.centerY)
        }
        chatLabel.snp.makeConstraints { make in
            make.centerX.equalTo(chatButton.snp.centerX)
            make.centerY.equalTo(editLabel.snp.centerY)
        }
        
        //right
        storyButton.snp.makeConstraints { make in
            make.centerX.equalTo(editButton.snp.centerX).offset(view.frame.width/4)
            make.centerY.equalTo(editButton.snp.centerY)
        }
        storyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(storyButton.snp.centerX)
            make.centerY.equalTo(editLabel.snp.centerY)
        }
    }
    private static func getLabel(text: String) -> UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }
    private static func getButton(iconName: String) -> UIButton{
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: iconName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.tintColor = .white
        return button
    }
}
