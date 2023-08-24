//
//  CustomViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/24.
//

import UIKit
import SnapKit

class CustomViewController: UIViewController {
    
    let idTextField = {
        let view = DefaultBlackBorderTextField()
        view.setupView()
        view.placeholder = "Enter Id"
        return view
    }()
    
    let passwordTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.isSecureTextEntry = true
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.placeholder = "Enter PW"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 12)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        
        idTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.height.equalTo(40)
        }

    }
    

}
