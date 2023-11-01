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
    
    let phone = BehaviorSubject(value: "010") //UI 보통 behavior
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
        buttonEnabled.bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        buttonColor.bind(to: nextButton.rx.backgroundColor, phoneTextField.rx.tintColor)
            .disposed(by: disposeBag)
        
        //border는 cg이기 때문에 map으로 변환 후 바인드
        buttonColor.map { $0.cgColor}
            .bind(to: phoneTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        phone.bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        //1 regular
        phone.map {$0.count == 13} //return bool
            .subscribe {value in
                let color = value ? UIColor.black : UIColor.red
                //                self.nextButton.isUserInteractionEnabled = value //이렇게 해도 되지만 버튼 상태를 조절할 다른 값 쓰는게 좋음
                self.buttonEnabled.onNext(value) // 아래 코드랑 같음
                //                self.buttonEnabled.on(.next(value))
                self.buttonColor.onNext(color)
            }.disposed(by: disposeBag)
        
        //2 unretained
        phone.map {$0.count == 13} //return bool
            .withUnretained(self) //메모리 관리 RxSwift6, subscribe에서 VC도 같이 나타남
            .subscribe {object, value in
                let color = value ? UIColor.black : UIColor.red
                object.buttonEnabled.onNext(value) // 아래 코드랑 같음
                object.buttonColor.onNext(color)
            }.disposed(by: disposeBag)
        
        
        //⭐️3 이게 제일 최신
        phone.map {$0.count == 13} //return bool
            .subscribe(with: self) { owner, value in //2번에서 이렇게 바뀜
                let color = value ? UIColor.black : UIColor.red
                owner.buttonEnabled.onNext(value) // 아래 코드랑 같음
                owner.buttonColor.onNext(color)
            }.disposed(by: disposeBag)
        
        
        //textfield 값을 phone에 전달. textfielddidchange유사
        phoneTextField.rx.text.orEmpty
            .subscribe {value in
                let result = value.formated(by: "###-####-####") //jack custom extension function
                print(value, result)
                self.phone.onNext(result)
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
//Xcode15 Macro allows better preview
//#Preview {
//    PhoneViewController()
//}
