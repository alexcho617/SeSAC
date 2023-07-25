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
        updateStatFromUserDefaults()
    }
    @IBAction func resetClicked(_ sender: UIButton) {
        ViewController.counterManager.resetCounterInUserDefaults()
        updateStatFromUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*
         //Delegate, UserDefaults, LocalStorage 등으로 개선 필요함.
         값의 변경이 없어도 무조건적으로 재호출하기때문에 비효율적임.
         하지만 view life cycle에 대해 배운것을 토대로 기능을 구현해본 점에서 의미가 있다고 생각함
         */
//        updateStat()
        
        //UserDefault 사용하는 함수
        updateStatFromUserDefaults()
    }
    
    //UserDefault 전에 사용했던코드
//    func updateStat(){
//        let dict = ViewController.counterManager.getDict()
//        //dict의 순서를 보장할수 없기때문에 키를 따로 작성.
//        let keys = ViewController.counterManager.getOrderedKeys()
//        for i in 0...dict.count - 1{
//            statButtonCollection[i].text = String(dict[keys[i]] ?? 0)+"점"
//        }
//    }
    
    //이거 비동기처리 안해도 되는건가...??
    func updateStatFromUserDefaults(){
        statButtonCollection[0].text = String(UserDefaults.standard.integer(forKey: "emoji0"))
        statButtonCollection[1].text = String(UserDefaults.standard.integer(forKey: "emoji1"))
        statButtonCollection[2].text = String(UserDefaults.standard.integer(forKey: "emoji2"))
        statButtonCollection[3].text = String(UserDefaults.standard.integer(forKey: "emoji3"))
        statButtonCollection[4].text = String(UserDefaults.standard.integer(forKey: "emoji4"))
    }
    
    
}
