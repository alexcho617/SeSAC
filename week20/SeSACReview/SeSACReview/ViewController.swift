//
//  ViewController.swift
//  SeSACReview
//
//  Created by Alex Cho on 12/1/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Viewwill APpear")
    }


}

extension UIViewController{
//    class func: type 오버라이드 가능, 클래스에서만 사용
//    static func type
//    func: Instance
    
    class func methodSwizzling(){
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillAppear)
        //runtime에서 실행됨
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin),
              let changeMethod = class_getInstanceMethod(UIViewController.self, change)
        else {
            print("No Function")
            return
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
    }
    
    //해당 함수가 뷰가 나타날때마다 실행됨.
    @objc func changeViewWillAppear(){
        //앱 분석 하는 이런저런 기능
        print(#function)
    }
}
