//
//  ViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/21.
//

import UIKit
/*
 1. 객체 얹이고 레이아웃잡고 아웃렛 연결 속성조절
 1. 뷰객체 프로퍼티 선언 (클래스 인스턴스 생성)
 2. 명시적으로 루트뷰에 추가
 3/ 크기과 위치 정의
 4. 속성정의
 
 Frame based layout의 한계
 AutoResizingMask, AutoLayout -> 스토리보드 대응
 NSLayoutConstraints => 오토레이아웃 대응
 */


class ViewController: UIViewController {
    
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayoutAnchor()
        view.addSubview(emailTextField)
        emailTextField.backgroundColor = .lightGray
        emailTextField.keyboardType = .emailAddress
        emailTextField.frame = CGRect(x: 50, y: 80, width: UIScreen.main.bounds.width - 100, height: 50)
        
        
        //password 필드를 이메일 밑에다가 넣어보자
        view.addSubview(passwordTextField)
        passwordTextField.backgroundColor = .cyan
        //스토리보드에서 하나의 constraint를 잡을 때 생기는 거랑 같음
        //AutoResizingMask랑 AutoLayout은 같이 못쓰기 때문에 코드에선 autolayout을 쓰게 되면 autoresizingmask 를 해제해야한다.
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        //addConstraints 방식
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
        
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50)
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50)
        view.addConstraints([leading,trailing,height,top])
        
        
        //isActive 방식
        //근데 이거는 클래스를 인스탄스화 하고 property까지 동시에 접근하네?
        //@MainActor가 뭐지?
//        NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
    }

    @objc func signButtonClicked(){
        //sb 이름 열거형으로 개선가능
        transition(style: .present, viewController: GenericViewController.self) //class itself
    }
    
    func setLayoutAnchor(){
        view.addSubview(signButton)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.backgroundColor = .blue
        signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300),
            signButton.heightAnchor.constraint(equalToConstant:  50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

