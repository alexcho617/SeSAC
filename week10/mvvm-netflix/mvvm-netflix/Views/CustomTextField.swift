//
//  CustomTextField.swift
//  mvvm-netflix
//
//  Created by Alex Cho on 2023/09/18.
//

import UIKit

class CustomGrayTextField: UITextField{
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
