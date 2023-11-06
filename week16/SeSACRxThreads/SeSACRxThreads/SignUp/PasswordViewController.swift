//
//  PasswordViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PasswordViewController: UIViewController {
   
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
//        aboutUnicast()
//        aboutMulticast()
        requestExample()
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PhoneViewController(), animated: true)
    }
    
    func configureLayout() {
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
         
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    //Observable이라 네트워크가 n번 호출되고 있음 따라서 unicast를 multi로 바꿔야함
    func requestExample(){
        let request = BasicAPIManager.fetchData()//.share() //.share로 멀티캐스트로 바꿈
        
        request.subscribe(with: self) { owner, value in
            print(value.resultCount)
        }
        .disposed(by: bag)

        request.map { data in
            "\(data.resultCount)개의 결과"
        }
        .bind(to: navigationItem.rx.title)
        .disposed(by: bag)
    }
    
    //Observable
    func aboutUnicast(){
        
        let random = Observable.create { value in
            value.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        //3곳에서 개별적인 구독: Observer 3개이며 랜덤 수가 다 다르다.
        random.subscribe(with: self) { owner, value in
            print(#function,value)
        }.disposed(by: bag)
        
        random.subscribe(with: self) { owner, value in
            print(#function,value)
        }.disposed(by: bag)
        
        random.subscribe(with: self) { owner, value in
            print(#function,value)
        }.disposed(by: bag)
        
        
    }
    
    //Subject
    func aboutMulticast(){
        let random = BehaviorSubject(value: 100)
        random.onNext(Int.random(in: 1...100))
        
        //3곳에서 같은 구독: Observer 3개이지만 값이 같음
        random.subscribe(with: self) { owner, value in
            print(#function,value)
        }.disposed(by: bag)
        
        random.subscribe(with: self) { owner, value in
            print(#function,value)
        }.disposed(by: bag)
        
        random.subscribe(with: self) { owner, value in
            print(#function,value)
        }.disposed(by: bag)
    }

}
