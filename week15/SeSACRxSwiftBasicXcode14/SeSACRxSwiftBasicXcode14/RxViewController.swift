//
//  RxViewController.swift
//  SeSACRxSwiftBasicXcode14
//
//  Created by jack on 2023/10/23.
//

import UIKit
import RxSwift
import RxCocoa

class RxViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var changeButton: UIButton!
    //    var nickname = Observable.just("고래밥") //just 연산자
    var nickname = BehaviorSubject(value: "고래밥")
    //    var nickname = BehaviorRelay(value: "고래밥")
    @IBOutlet var timerLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sample()
        
        nickname
            .bind(to: nameLabel.rx.text) //가변 매개변수: 여러개 넣을 수 있음
            .disposed(by: disposeBag)
        
        //        //observable
        //        nickname.subscribe { value in //next
        //            print(value)
        //            self.nameLabel.text = value
        //        } onError: { error in
        //            print(error)
        //        } onCompleted: {
        //            print("nickname - onCompleted")
        //        } onDisposed: {
        //            print("nickname = onDisposed")
        //        }
        //        .dispose()
        
        changeButton.rx.tap
            .subscribe { value in
                print("버튼 클릭 \(value)")
                self.nickname.onNext("버튼 클릭 \(Int.random(in: 1...100))")
            } onError: { error in
                print("changeButton - onError")
            } onCompleted: {
                print("changeButton - onCompleted")
            } onDisposed: {
                print("changeButton - Disposed")
            }
            .disposed(by: disposeBag)
        
        //Rx
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("value:",value)
                self.timerLabel.text = "\(value)"
            } onError: { error in
                print("interval - \(error)")
            } onCompleted: {
                print("interval completed")
            } onDisposed: {
                print("interval disposed")
            }
            .disposed(by: disposeBag) //수동으로 처리해야 할 때도 있음
        
        //5초 뒤에 수동으로 처리
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.disposeBag = DisposeBag()
        }
    }
    
    func sample(){
        let item = [1,2,3,4,5]
        let item2 = [5,4,3,2,1]
        //just는 그냥 보냄,
//        Observable.just(item) 1개 왜 구분했나? of 하나만 있으면 되는거 아닌가
//        Observable.of(item, item2) //여러개, onNext 여러번
//        Observable.from(item) //array element 하나씩 전달 (for)
        Observable.repeatElement(1) //무한반복
            .take(5) //n번 반복
            .subscribe { val in
                print("Subscribe - \(val)")
            } onError: { error in
                print("Error - \(error)")
            } onCompleted: {
                print("onCompleted")
                //dispose
            } onDisposed: {
                print("onDisposed")
                //dispose
            }.disposed(by: disposeBag)

    }
}
