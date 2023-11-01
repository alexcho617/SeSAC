//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = UIButton()
    let test = UISwitch()
    let disposeBag = DisposeBag()
    
    //전달
//    let isOn = Observable.of(false) //Observable 생성/전달만 가능
//    let isOn = BehaviorSubject(value: true) //초기값
    let isOn = PublishSubject<Bool>() //초기값 없음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testSwitch()
        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
    }
    
    @objc func signUpButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    func testSwitch(){
        view.addSubview(test)
        test.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.leading.equalTo(100)
        }
        //구독1
//        isOn
//            .subscribe { value in
//                self.test.setOn(value, animated: true)
//            }
//            .disposed(by: disposeBag)
        
        //구독2
        isOn
            .bind(to: test.rx.isOn) //animation은?
            .disposed(by: disposeBag)
        //시점 중요. 구독 후 데이터 변경해야하
        isOn.onNext(true) //publishsubject 경우 직접 초기값 전달

        //데이터 변경
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.isOn.onNext(false)
        }
//        UIKit
//        test.setOn(true, animated: true)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//            self.test.setOn(false, animated: true)
//        }
        

    }
    func configure() {
        signUpButton.setTitle("회원이 아니십니까?", for: .normal)
        signUpButton.setTitleColor(Color.black, for: .normal)
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
