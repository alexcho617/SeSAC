//
//  SignUpViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum MyError: Error{
    case defaultError
}

class SignUpViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let validationButton = UIButton()
    let nextButton = PointButton(title: "다음")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
//        disposeExample()
//        incrementExample()
//        aboutPublishSubject()
//        aboutReplaySubject()
        aboutAsyncSubject()
    }
    
    //publish subject는 초기값이 없음
    func aboutPublishSubject(){
        let publish = PublishSubject<Int>()
        
        publish.onNext(20)
        publish.on(.next(30))
        
        //구독시점
        publish.subscribe(with: self) { owner, value in
            print("PublishSubject \(value)")
        } onError: { owner, error in
            print("PublishSubject \(error)")
        } onCompleted: { owner in
            print("PublishSubject Completed")
        } onDisposed: { owner in
            print("PublishSubject disposed")
        }.disposed(by: disposeBag)
        
        publish.onNext(1)
        publish.onNext(2)
        publish.onNext(3)
//        publish.onCompleted()
        publish.onError(MyError.defaultError)
        publish.onNext(4)
        publish.onNext(5)
    }
    
    func aboutBehaviorSubject(){
        let behavior = BehaviorSubject(value: 200)
        
        behavior.on(.next(20))
        behavior.on(.next(30)) //예는 왜 나옴? 구독 전 마지막 값을 가지고 있음
        
        //구독시점
        behavior.subscribe(with: self) { owner, value in
            print("BehaviorSubject \(value)")
        } onError: { owner, error in
            print("BehaviorSubject \(error)")
        } onCompleted: { owner in
            print("BehaviorSubject Completed")
        } onDisposed: { owner in
            print("BehaviorSubject disposed")
        }.disposed(by: disposeBag)
        
        behavior.onNext(1)
        behavior.onNext(2)
        behavior.onNext(3)
//        publish.onCompleted()
        behavior.onError(MyError.defaultError)
        behavior.onNext(4)
        behavior.onNext(5)
    }
    
    //버퍼사이즈만까지 최근 값들을 저정함
    func aboutReplaySubject(){
        let replay = ReplaySubject<Int>.create(bufferSize: 3) //버퍼가 엄청 크다면...?
        
        replay.on(.next(20))
        replay.on(.next(30))
        replay.on(.next(40))
        replay.on(.next(50))
        
        //구독시점
        replay.subscribe(with: self) { owner, value in
            print("ReplaySubject \(value)")
        } onError: { owner, error in
            print("ReplaySubject \(error)")
        } onCompleted: { owner in
            print("ReplaySubject Completed")
        } onDisposed: { owner in
            print("ReplaySubject disposed")
        }.disposed(by: disposeBag)
        
        replay.onNext(1)
        replay.onNext(2)
        replay.onNext(3)
//        publish.onCompleted()
        replay.onError(MyError.defaultError)
        replay.onNext(4)
        replay.onNext(5)
    }
    
    //Complete 기준으로 가장 직전의 이벤트를 전달
    func aboutAsyncSubject(){
        let async = AsyncSubject<Int>()
        
        async.on(.next(20))
        async.on(.next(30))
        async.on(.next(40))
        async.on(.next(50))
        
        //구독시점 상관 없음
        async.subscribe(with: self) { owner, value in
            print("AsyncSubject \(value)")
        } onError: { owner, error in
            print("AsyncSubject \(error)")
        } onCompleted: { owner in
            print("AsyncSubject Completed")
        } onDisposed: { owner in
            print("AsyncSubject disposed")
        }.disposed(by: disposeBag)
        
        async.onNext(1)
        async.onNext(2)
        async.onNext(3)
        async.onCompleted()
//        async.onError(MyError.defaultError)
        async.onNext(4)
        async.onNext(5)
    }
    
    func disposeExample(){
        //유한한 데이터, 방출만 가능, 다 보내면 해제됨.
//        let textArray = Observable.from(optional: ["alex","blex","clex"])
        //subject
        let textArray = BehaviorSubject(value: ["alex","blex","clex"])
        
        let textArrayValue = textArray.subscribe(with: self) { owner, value in
            print("next", value)
        } onError: { owner, error in
            print("error", MyError.defaultError)
        } onCompleted: { owner in
            print("completed")
        } onDisposed: { owner in
            print("disposed")
        }
//        .disposed(by: disposeBag)
        
        textArray.onNext(["dlex","elex"])
        textArray.onNext(["f","g"])
        textArray.onError(MyError.defaultError)
        textArray.onNext(["h","i"])
        
        
        //error 만나면 무조건 해제하지만 별개로 dispose시점을 제어하고 싶을때 사용
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            textArrayValue.dispose()
        }
     
        
        
    }
    
    func incrementExample() {
        let increment = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        increment.subscribe(with: self) { owner, value in
            print("next \(value)")
        } onError: { owner, error in
            print("error", error)
        } onCompleted: { owner in
            print("Completed")
        } onDisposed: { owner in
            print("disposed")
        }

    }
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PasswordViewController(), animated: true)
    }

    func configure() {
        validationButton.setTitle("중복확인", for: .normal)
        validationButton.setTitleColor(Color.black, for: .normal)
        validationButton.layer.borderWidth = 1
        validationButton.layer.borderColor = Color.black.cgColor
        validationButton.layer.cornerRadius = 10
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(validationButton)
        view.addSubview(nextButton)
        
        validationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    deinit {
        print("sign up deinit")
    }

}
