//
//  SimpleTableviewViewController.swift
//  SeSACRxSwiftBasicXcode14
//
//  Created by Alex Cho on 2023/11/01.
//

import UIKit
import RxSwift
import RxCocoa

//여기서 그냥 ViewController 상속 받아도 됨
class SimpleTableviewViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var simplePicker: UIPickerView!
    @IBOutlet weak var simpleLabel: UILabel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let items = Observable.just(
            (0..<20).map{"\($0)"}
        )
        
        //tableview cell 만들기
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row,element,cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                
            }.disposed(by: disposeBag)
        
        //didselect row at
        tableView.rx.modelSelected(String.self)
            .map { data in
                "\(data) clicked"
            }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
        
        //pickerview items
        items
            .bind(to: simplePicker.rx.itemTitles) { (row, element) in
            return element
        }.disposed(by: disposeBag)
        
        simplePicker.rx.modelSelected(String.self)
            .map { val in
                val.description
            }
            .bind(to: simpleLabel.rx.text)
//            .subscribe(onNext: { value in
//                self.simpleLabel.text = value
//                print(value)
//            })
            .disposed(by: disposeBag)
    }
    
}
