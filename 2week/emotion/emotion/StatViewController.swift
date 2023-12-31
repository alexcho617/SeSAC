//
//  StatViewController.swift
//  emotion
//
//  Created by Alex Cho on 2023/07/25.
//

import UIKit

class StatViewController: UIViewController {
    @IBOutlet var titleLabelCollection: [UILabel]!
    
    @IBOutlet var statButtonCollection: [UILabel]!
    
    @IBOutlet var statRowStackCollection: [UIStackView]!
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatView()
    }
    
    @IBAction func resetClicked(_ sender: UIButton) {
        ViewController.counterManager.resetCounterInUserDefaults()
        updateStatFromUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        //didset으로 옵저버 대체 가능
//        var a = 10 {
//            didSet{
//                print("set")
//                print(newValue)
//            }
//        }
        //Observer가 없기때문에 여기서 실행
        super.viewWillAppear(animated)//super같이 실행
        updateStatFromUserDefaults()
    }
    
    func setStatView(){
        for label in titleLabelCollection{
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 24)
        }
        for stat in statButtonCollection{
            stat.textColor = .white
            stat.font = .boldSystemFont(ofSize: 24)
        }
        
        for stackRow in statRowStackCollection{
            stackRow.layer.cornerRadius = 15
            
        }
    }
    
    func updateStatFromUserDefaults(){
        for i in 0...4{
            statButtonCollection[i].text = String(UserDefaults.standard.integer(forKey: "emoji"+String(i))) + "점"
        }
    }
    
    
}
