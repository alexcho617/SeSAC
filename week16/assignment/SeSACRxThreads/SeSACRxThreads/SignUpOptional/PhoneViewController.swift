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
    
    let phoneNumber = BehaviorSubject(value: "010")
//    let phone = BehaviorSubject(value: "010")
    let buttonColor = BehaviorSubject(value: UIColor.red)
    let buttonEnabled = BehaviorSubject(value: false)
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
        buttonEnabled.bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)

        //buttonColor <->button background, textfield color
        buttonColor.bind(to: nextButton.rx.backgroundColor, phoneTextField.rx.tintColor)
            .disposed(by: disposeBag)

        //buttonColor <-> textfield border
        buttonColor.map {$0.cgColor}
            .bind(to: phoneTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)

        //number <-> textfield text
        phoneNumber.bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        //number -> bool <->button enabled, buttonColor
        phoneNumber.map {$0.count == 13}
            .subscribe(with: self) { owner, value in
                owner.buttonEnabled.onNext(value)
                owner.buttonColor.onNext(value ? UIColor.black : UIColor.red)
            }.disposed(by: disposeBag)

        //textfield text <-> number
        phoneTextField.rx.text.orEmpty
            .subscribe(with: self) { owner, value in
                let result = value.formated(by: "###-####-####")
                owner.phoneNumber.onNext(result)
            }.disposed(by: disposeBag)
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
