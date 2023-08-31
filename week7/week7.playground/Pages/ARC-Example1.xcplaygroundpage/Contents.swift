import UIKit

//Any vs AnyObject
/*
 Any: 모든 타입에 대해 대응 가능 (구조체, 열거형, 클래스, 클로저) -> 런타임 타입 확인
 AnyObject: 모든 클래스 타입의 인스턴스만 담을 수 있음 -> 클래스 제약 설정 가능: TypeAlias
 Void도 typealias이다. typealias Void = ()
 
 */
//typealias man = false
let name = "Alex"
let age = 10
//let gender = man
let birthDate = Date()
//let arrayList: [Any] = [name,age,gender,birthDate]

//Cannot convert value of type 'Bool' to expected element type 'AnyObject'
//let anotherList: [AnyObject] = [name,age,gender,birthDate]

//런타임 일때 결정 되기 때문에 런타임 오류 발생 가능 -> 타입 캐스팅 필요
//arrayList[1] as! Int + 10


//AnyObject 이전에 class로 되어있었음.   
protocol Sample: AnyObject{
    func example()
}

class UserClass: Sample{
    func example() {
        
    }
}
//Non-class type 'UserStruct' cannot conform to class protocol 'Sample'
//struct UserStruct: Sample{
//    func example() {
//    }
//}
