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
    var disposeBag = DisposeBag()
    
    //전달
//    let isOn = Observable.of(false) //Observable 생성/전달만 가능
//    let isOn = BehaviorSubject(value: true) //초기값
    let isOn = PublishSubject<Bool>() //초기값 없음
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testSwitch()
//        incrementExample()
        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
        bind()
        aboutCombineLatest()
    }
    
    //전달하려는 observable이 한번이상 방출 되어야 결합한다. 따라서 publish는 초기값이 없기때문에 실행되지 않았다. Behavior는 초기값이 있기 때문에 모두 전달이 되었다.
    func aboutCombineLatest(){
        let a = PublishSubject<Int>()//BehaviorSubject(value: 1)
        let b = PublishSubject<String>()//BehaviorSubject(value: "a")
        Observable.combineLatest(a, b) {first, second in
            return "결과: \(first), and \(second)"
        }
        .subscribe(with: self) { owner, value in
            print(value)
        }.disposed(by: disposeBag)
        
        a.onNext(2)
        a.onNext(3)
        a.onNext(4)

        b.onNext("b")
        b.onNext("c")
        b.onNext("d")
    }
    
    
    func bind(){
        //combinelatest 그냥 오퍼레이터 중 하나니까 큰 줄기를 잊지말자
        
        //bind 안걸었는데 email, password는 어떻게 바뀜? RxCocoa 에서 UITextField 경우 .rx로 래핑 할 경우 이벤트를 방출 함
        let email = emailTextField.rx.text.orEmpty
        let password = passwordTextField.rx.text.orEmpty
        
        //combine latest, with result selector 8개 제한
        //resultSelector는 뭐지?
        //이렇게 말고 UI처리는 각각 해주고 validation은 둘 다 합치고 싶으면?
        //방출
        let validation = Observable.combineLatest(email, password) { first, second in
            return first.count > 8 && second.count >= 6
        }
        
        
        
        
        //구독
        validation
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        //이렇게 말고 이메일이랑 패스워드 validation은 각각 해주고 전체 validation을 합쳐서 하고싶다면?
        validation
            .subscribe(with: self) { object, value in
                object.signInButton.backgroundColor = value ? UIColor.black : UIColor.gray
                object.emailTextField.layer.borderColor = value ? UIColor.black.cgColor : UIColor.red.cgColor
                object.passwordTextField.layer.borderColor = value ? UIColor.black.cgColor : UIColor.red.cgColor
            }.disposed(by: disposeBag)
        
        signInButton.rx.tap
            .subscribe(with: self) { owner, value in
                print("Select")
            }.disposed(by: disposeBag)
    }
    
    
    @objc func signUpButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    func incrementExample() {
        let increment = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        //root vc이기 때문에 deinit 안됨. explicit하게 해야함
        increment.subscribe(with: self) { owner, value in
            print("next \(value)")
        } onError: { owner, error in
            print("error", error)
        } onCompleted: { owner in
            print("Completed")
        } onDisposed: { owner in
            print("disposed")
        }.disposed(by: disposeBag)
        
        increment.subscribe(with: self) { owner, value in
            print("next \(value)")
        } onError: { owner, error in
            print("error", error)
        } onCompleted: { owner in
            print("Completed")
        } onDisposed: { owner in
            print("disposed")
        }.disposed(by: disposeBag)
        
        increment.subscribe(with: self) { owner, value in
            print("next \(value)")
        } onError: { owner, error in
            print("error", error)
        } onCompleted: { owner in
            print("Completed")
        } onDisposed: { owner in
            print("disposed")
        }.disposed(by: disposeBag)
        
        //explicitly dispose
        //버튼이나 사용자 액션에 따라 해제 가능
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            
            //이런게 여러개 있다면? 개별적으로 정리해야함 -> instance 교채
            self.disposeBag = DisposeBag() //한번에 없어짐
//            incrementValue.dispose()
//            incrementValue2.dispose()
//            incrementValue3.dispose()
            
        }

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
