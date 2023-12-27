//
//  SwiftViewController.swift
//  WebSocket
//
//  Created by Alex Cho on 12/27/23.
//

import UIKit

let age = Int.random(in: 1...100)
let status: Int? = 200
class SwiftViewController: UIViewController {
    
    //함수를 호출하거나 closure로 초기화 할 수 있음
    let randomResult = {
        switch age{
        case 1...30: return "Student"
        case 31...60: return "Adult"
        case 61...100: return "Senior"
        default: return "Unknown"
        }
    }()
    
    //Swift 5.9 논리 연산자를 프로퍼티로?
    let newResult = if age < 20 {"Student"}
    else if age < 31 && age < 60 {"Adult"}
    else {"Senior"}
    let userStatus = if (status != nil) {UIColor.black} else {UIColor.red}
    let newResultSwitch = switch age{
    case 1...30: "Student"
    case 31...60: "Adult"
    case 61...100: "Senior"
    default: "Unknown"
    }
    
    //고도화 된 뷰
//    let views = SeSACFactory.make(.label)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //사용
        example(a: 3)
        example(a: "HI")
        //두개를 받으려면?
        example(a: 3, b: 4)
        
        let result = exampleEachGeneric(a: 1,2,3,"1") // Tuple
        result.0
    }
    
    func randomAge() -> String {
        switch age{
        case 1...30: return "Student"
        case 31...60: return "Adult"
        case 61...100: return "Senior"
        default: return "Unknown"
        }
    }
    
    func randomAgeTwo() -> String {
        if age < 30 {
            return "Student"
        } else if age < 31 && age < 60{
            return "Adult"
        }else{
            return "Senior"
        }
    }
    
    //generic study: 이렇게 사용, 프로토콜로 제약 둘 수 있음
    func example<T>(a: T){
        print(a)
    }
    
    //오버로딩을 사용했음 -> 계속 정의해야하기 때문에 문제 있음
    //Swift 5.7
    //Generic에 타입이 옵셔널이 원래 불가능 했으나 가능해짐
    func example<T, K>(a: T, b: K){
        print(a,b)
    }
    
    //해결 each: 몇개가 올진 모르겠으나 같은 타입이면 갯수 상관 없음
    func exampleEachGeneric<each T>(a: repeat (each T)) -> (repeat each T) {
        return (repeat each a) //Parameter Pack:튜플로 담아서 보낸다
    }
    
    
//    //15이상, 16.4미만
//    @backDeployed(before: iOS 16.4) //internal 불가, 상한선 정의
//    @available(iOS 15.0, *)
//    func randomAgeTwo() -> String {
//        if age < 30 {
//            return "Student"
//        } else if age < 31 && age < 60{
//            return "Adult"
//        }else{
//            return "Senior"
//        }
//    }
    
}

//MARK: Factory Pattern
//이걸 어떻게 개선할까? Init이 번거롭다. 프로토콜을 사용해보자
final class SeSACLabel: UILabel{
    init(textColor: UIColor, backgroundColor: UIColor){
        super.init(frame: .zero)
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum SeSACComponent{
    case label
    case button
}

protocol SeSACUIComponent{
    var component: SeSACComponent{ get }
    var color: UIColor {get set}
    var backgroundColor: UIColor {get set}
}
//
//final class NewLabel: UILabel, SeSACUIComponent{
//    var component: SeSACComponent = .label
//    var color: UIColor
//    var backgroundColor: UIColor
//    
//    init(color: UIColor, backgroundColor: UIColor) {
//        self.color = color
//        self.backgroundColor = backgroundColor
//        
//        super.init(frame: .zero)
//        
//        self.textColor = color
//        self.backgroundColor = backgroundColor
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//struct SeSACFactory{
//    static func make(_ component: SeSACComponent) -> SeSACUIComponent{
//        switch component {
//        case .label:
//            return NewLabel(color: .blue, backgroundColor: .red)
////        case .button:
//        default:
//            return NewLabel(color: .blue, backgroundColor: .red)
//        }
//    }
//}

//사용
//let views = SeSAC.make(.label)

