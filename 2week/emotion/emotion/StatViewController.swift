//
//  StatViewController.swift
//  emotion
//
//  Created by Alex Cho on 2023/07/25.
//

import UIKit

class StatViewController: UIViewController {
    
    @IBOutlet var statButtonCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStat()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*
         //Delegate, UserDefaults, LocalStorage 등으로 개선 필요함.
         현재는 값의 변경이 없어도 무조건적으로 재호출하기때문에 비효율적임.
         하지만 view life cycle에 대해 배운것을 토대로 기능을 구현해본 점에서 의미가 있다고 생각함
         */
        updateStat()
    }
    public func updateStat(){
        let dict = ViewController.counterManager.counterDict
        //dict의 순서를 보장할수 없기때문에 키를 따로 작성.
        let keys = [
            "emoji1",
            "emoji2",
            "emoji3",
            "emoji4",
            "emoji5"
        ]
        for i in 0...dict.count - 1{
            statButtonCollection[i].text = String(dict[keys[i]] ?? 0)+"점"
        }
    }
}
