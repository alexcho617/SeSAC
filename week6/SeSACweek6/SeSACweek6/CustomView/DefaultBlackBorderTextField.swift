//
//  defaultBlackBorderTextField.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/24.
//

import UIKit


class DefaultBlackBorderTextField: UITextField{
    ///2개의 init은 둘 중 1개만 실행되지만 프로토콜로 묶여있기 때문에 쓰긴해야한다.
    //UIView
    //Interace BUilder를 사용하지 않고 UIView를 상속받는 Custom Class에서 뷰를 생성할때 사용됨
    override init(frame: CGRect) { // UIView
        super.init(frame: frame)
        setupView()
    }
    
    //NSCoding
    //Storyboard(XIB) -> NIB 변환과정에서 필요
    //Interface Builder에서 생성된 뷰들이 초기화될때 실행되는 구문
    //init? 으로 되어있기 때문에 실패할수 있게 되어있다.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        borderStyle = .none
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        textAlignment = .center
        font = .boldSystemFont(ofSize: 12)
    }
    
}

protocol ExampleProtocol{
    init(name: String)
}

class Mobile: ExampleProtocol{
    required init(name: String) { //required: Protocol 에서 생성한 init
        
        
    }
    
    
}
