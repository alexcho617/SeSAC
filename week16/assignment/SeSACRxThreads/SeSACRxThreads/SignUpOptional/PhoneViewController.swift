//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {
    
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let vm = PhoneViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.white
        
        configureLayout()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        bind()
    }
    
    func bind(){
        //buttonEnabled <->button
        vm.buttonEnabled.bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        vm.buttonEnabled
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onNext: { owner, value in
                print("vm.buttonEnabled:",value)
                owner.nextButton.tintColor = value ? UIColor.black : UIColor.red
                owner.nextButton.layer.borderColor = value ? UIColor.black.cgColor : UIColor.red.cgColor
            })
            .disposed(by: disposeBag)
        
        
        //number <-> textfield text
        vm.phoneNumber.bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        //textfield text <-> number
        phoneTextField.rx.text.orEmpty
            .subscribe(with: self) { owner, value in
                self.vm.phoneNumber.onNext(value.formated(by: "###-####-####"))
            }
            .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(NicknameViewController(), animated: true)
    }
    
    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
        
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
}
