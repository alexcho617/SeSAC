//
//  LoginViewController.swift
//  week6-assign
//
//  Created by Alex Cho on 2023/08/24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 48)
        label.textColor = .red
        label.text = "ALFLIX"
        return label
    }()
    let email = DefaultGrayTextField(placeholder: "이메일 혹은 전화번호")
    let password = DefaultGrayTextField(placeholder: "비밀번호", isSecureText: true)
    let nickname = DefaultGrayTextField(placeholder: "닉네임")
    let location = DefaultGrayTextField(placeholder: "위치")
    let refer = DefaultGrayTextField(placeholder: "추천 코드 입력")
    lazy var stackView = {
        lazy var view = UIStackView(arrangedSubviews: [self.email, self.password, self.nickname, self.location, self.refer])
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    let signUpButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let additional = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let switchButton = {
        let view = UISwitch()
        view.onTintColor = .red
        view.tintColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(signUpButton)
        view.addSubview(additional)
        view.addSubview(switchButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(40)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(40)
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.height.equalTo(60)
        }
        
        additional.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(40)
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
        }
        
        switchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
        }

        signUpButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(){
        print("BUtton")
    }
}

class DefaultGrayTextField: UITextField{
    init(placeholder: String, isSecureText: Bool = false){
        super.init(frame: .zero)
        setup(with: placeholder, isSecure: isSecureText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with placeholder: String, isSecure: Bool){
        isSecureTextEntry = isSecure
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textAlignment = .center
        backgroundColor = .systemGray
        textColor = .white
        layer.cornerRadius = 4
        borderStyle = .none
        
    }
}
