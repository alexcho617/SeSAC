//
//  DetailViewController.swift
//  first
//
//  Created by Alex Cho on 2023/07/19.
//

import UIKit
@available(iOS 15.0, *)
class KeyboardViewController: UIViewController {

    @IBOutlet var newButton: UIButton!
    //여러 종류의 객체에서 같은 액션을 할 때만 any를 쓰는게 바람직하다. 하지만 액션 안에서 sender parameter로 프라퍼티 엑세스 불가능
    @IBAction func dismissKeyboard(_ sender: Any) {
        if let button = sender as? UIButton {
            print(String(describing: button.titleLabel!.text))
            view.endEditing(true)
        }
        else{
            print("not button")
        }
    }
    
    override func viewDidLoad() {
        //ios15
        var buttonConfig = UIButton.Configuration.filled()//apple system button
        buttonConfig.title = "Alex"
        buttonConfig.subtitle = "iOS Dev"
        buttonConfig.image = UIImage(systemName: "star")
        buttonConfig.cornerStyle = .capsule
        
        buttonConfig.baseForegroundColor = .black
        buttonConfig.baseBackgroundColor = .orange
        buttonConfig.imagePadding = 8
        buttonConfig.imagePlacement = .trailing
        buttonConfig.titleAlignment = .trailing
        
        newButton.configuration = buttonConfig
        super.viewDidLoad()
    }
    
    

}
