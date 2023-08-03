//: [Previous](@previous)

import Foundation
import UIKit

protocol AlexTableViewProtocol{
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
}

//class vc: UIViewController, AlexTableViewProtocol{
//    func numberOfRowsInSection() -> Int {
//        <#code#>
//    }
//
//    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}


//optional requirement는 클래스에서만 사용할수 있는데 그 이유는 objc땐 클래스밖에 없었음.
@objc
protocol ViewPresentableProtocol {
    //최소 요구사항 (그렇다면 겟만 할 수 있는건 뭐지?)
    //변수명만 같으면 저장이든 연산이든 상관없음
    @objc optional var navigationTitle: String {get set}
    var backgroundColor: UIColor {get}
    var identifier: String {get}
    
    func configureView()
    func configureLabel()
    @objc optional func configureTextField()
}

class A: UIViewController, ViewPresentableProtocol{
    var navigationTitle: String = "검색"
    
    var backgroundColor: UIColor = .red
    
    var identifier: String = "identifier"
    
    
    func configureView() {
            
    }
    
    func configureLabel() {
            
    }
    
    func configureTextField() {
            
    }
}

class BViewController: UIViewController,ViewPresentableProtocol{
    var navigationTitle: String{
        get{
            return "My Diary"
        }
        set{
            newValue
        }
        
    }
    
    var backgroundColor: UIColor {
        return .systemRed
    }
    
    var identifier: String{
        return "BViewController"
    }
    
    func configureView() {
            
    }
    
    func configureLabel() {
            
    }
    
    func configureTextField() {
            
    }
    
    
}

//: [Next](@next)
