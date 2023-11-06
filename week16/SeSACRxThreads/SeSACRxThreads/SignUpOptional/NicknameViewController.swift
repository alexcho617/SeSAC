//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
       
//        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        bind()
    }
    
    func bind(){
        let tap = nextButton.rx.tap
            .map{"Foo\(Int.random(in: 1...100))"} //observable 특성으로 unicast
            .asDriver(onErrorJustReturn: "") //Driver<String>
        
        tap.drive(with: self) { owner, value in
            owner.nextButton.setTitle(value, for: .normal)
        }.disposed(by: bag)
        
        tap.drive(with: self) { owner, value in
            owner.nicknameTextField.text = value
        }.disposed(by: bag)
        
        tap.drive(with: self) { owner, value in
            owner.navigationItem.title = value
        }.disposed(by: bag)
    }
    
//    @objc func nextButtonClicked() {
//        navigationController?.pushViewController(BirthdayViewController(), animated: true)
//    }

    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
         
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
