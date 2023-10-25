//
//  BasicViewController.swift
//  SeSACRxSwiftBasicXcode14
//
//  Created by Alex Cho on 2023/10/25.
//

import UIKit
import RxSwift
import RxCocoa

class BasicViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicTableView()
//        basicButton()
        shareButton()
        basicValidation()
    }
    
    //bind: main thread, error x completed x
    //drive: Bind + stream shared
    func shareButton(){
        //1개의 observable, 3개의 observers 근데 3:3 처럼 동작하고 있음 숫자가 다 다름
        let sample = button.rx.tap
            .map {"HiHi \(Int.random(in: 1...100))"}
            .share() //stream 공유
        sample
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        sample
            .bind(to: textField.rx.text)
            .disposed(by: disposeBag)
        sample
            .bind(to: button.rx.title()) //자기 자신
            .disposed(by: disposeBag)
        
    }
    
    func basicValidation(){
        textField.rx
            .text //String?
            .orEmpty //String optional 해제
            .map { $0.count > 4 } // bool로 변경함
            .bind(to: button.rx.isEnabled) //
            .disposed(by: disposeBag)
    }
    
    func basicTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        
        //cell selectable
        //string 배열 사용중
        tableView
            .rx
            .modelSelected(String.self)
            .map{data in //data로 변경
                "\(data)를 클릭했어"
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        
    }
    
    func basicButton(){
        //        button.rx.tap.bind(to: label.rx.text)
        button.rx.tap
            .observe(on: MainScheduler.instance) //main thread 동작 기존 dispatchqueue.main.async 대체
            .subscribe { _ in //next complete error 다 가능
                self.label.text = "Button Clicked1"
                self.textField.text = "Button Clicked1"
                print("Button click1")
                }
            //    onError: { error in
            //        print(error)
            //    } onCompleted: {
            //        print("Completed")
            //    }
                onDisposed: {
                    print("Disposed")
                }
        button.rx.tap
            .bind { _ in //next만 가능, 메인쓰레드 동작 보장
                self.label.text = "Button Clicked2"
                self.textField.text = "Button Clicked2"
                print("Button click2")
            }
        
        button.rx.tap
        //변환해주어야 text에서 받을 수 있다. 타입을 맞춰줘야한다
            .map{ "클릭 되었어요"} //control event(tap) -> String
            .bind(to: label.rx.text, textField.rx.text)
            .disposed(by: disposeBag)
    }
}



//tableView.rx
//    .modelSelected(String.self)
//    .subscribe(onNext:  { value in
//        DefaultWireframe.presentAlert("Tapped `\(value)`")
//    })
//    .disposed(by: disposeBag)
//
//tableView.rx
//    .itemAccessoryButtonTapped
//    .subscribe(onNext: { indexPath in
//        DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
//    })
//    .disposed(by: disposeBag)
