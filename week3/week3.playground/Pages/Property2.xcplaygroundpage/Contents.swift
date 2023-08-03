//: [Previous](@previous)

import UIKit

//Property: Instance Property (must init class or struct to access) 저장 프로퍼티

struct User{
    //인스턴스 프로퍼티 + 저장 프로퍼티
//    var nickname = "Bob"//선언 초기화 동시
    var nickname: String //선언만
    
    static var originName: String = "진짜 이름" //타입 프로퍼티 + 저장 프로퍼티
    //사용하는 순간 메모리에 올라가고 앱 종료까지 메모리 유지 (지연저장 lazy처럼 동작)
    
    //연산 프로퍼티 Computed Property
    //값을 초기화 하고 저장하는 공간이 없음. 다른 저장 프로퍼티의 값을 연산해서 간접적으로 제공함
    //함수에 비해 장점이 있나?
    var userIntro: String{
        get {
            return "nick: \(nickname) real name: \(User.originName)"
        }
    }
}

let user = User(nickname: "Bob") //이미 닉네임을 초기화를해서 생성됨
//print(user.nickname) //instance properties cannot be accessed until initialized


//print(User.originName) //타입 프로퍼티이기 때문에 바로 접근 가능, 인스탄스로는 접근 안됨

let user2 = User(nickname: "Bran")
let user3 = User(nickname: "Jack")

User.originName //regardless of instances only one value
//print(User.originName)
User.originName = "찐 진짜 이름"
//print(User.originName)

//print(User(nickname: "Alex").userIntro)

//UILabel().text = user3.userIntro
let computedProperty = user3.userIntro
//print(computedProperty)



struct BMI{
    var nickname: String{
        
        //use newValue
        willSet{
            print("will set \(nickname) to " + newValue)
        }
        
        //use oldValue
        didSet{
            print("didset \(oldValue) to " + nickname)
        }
        
    }
    
    var weight: Double //instance, stored property
    var height: Double //인스탄스 저장 프로퍼티
    
    var result: String{ //연산 Computed property
        get{
            let bmiValue = (height * height) / weight
            let bmiStatus = bmiValue < 18.5 ? "Low" : "Normal"
            return "\(nickname) bmi: \(bmiValue) and u are \(bmiStatus)" //이걸 구조체 안으로 넣자
        }
        set{
            nickname = newValue
        }
    }
}
var bmi = BMI(nickname: "Cheetos", weight: 70, height: 180)
print(bmi.result)
bmi.result = "Nachos"
//print("ur bmi: \(bmiValue) and u are \(bmiStatus)") //이걸 구조체 안으로 넣자ㅌ
print(bmi.result)
//: [Next](@next)


//as instance
class FoodRestaurant{
    let name = "Alchick" //stored instance property
    var totalOrderCount = 10 //stored instance property
    var newOrder: Int{
        get{
            return totalOrderCount * 5000
        }
        set{
            totalOrderCount += newValue
        }
    }
}

let food = FoodRestaurant()
food.newOrder
food.newOrder = 30
food.newOrder

//as type
class TypeFoodRestaurant{
    static let name = "Alchick"
    static var totalOrderCount = 10
    static var newOrder: Int{
        get{
            return totalOrderCount * 5000
        }
        
        set{
            totalOrderCount += newValue
        }
    }
}

TypeFoodRestaurant.newOrder
TypeFoodRestaurant.newOrder = 60
TypeFoodRestaurant.newOrder


class Coffee{
    static var name = "americano"
    static var shot = 2
    static func addShot(){
        shot += 1
    }
}



class Latte: Coffee{
    //override 할 수 없다는데 왜 하는거지?? 클래스쓴 의미가 뭐지?
//    override class func addShot(){
//        
//    }
}









//Enum: 컴파일때 결정되서 instance 생성 불가 -> 인스탄스 프로퍼티/인스탄스 메서드 사용 불가
//static let 으로 값을 저장하는것과 case rawvalue 의 차이는?
enum Grade: String{
    case a = "100점", b,c,d,e
    
//    var intro: String
    static let introduce = "grade" //stored type property 사용 가능
    static var aa = "dd"
}
Grade.aa = "vv"

print(Grade.aa)

enum Resource: String{
    case save = "저장"
//    case add = "추가" //이 값이 여러번 사용되는경우?
//    case addButton = "추가" //rawvalue는 고유해야하기 때문에 안됨
    static let add = "추가" //이렇게 하면 같은 값을 여러번 쓸 수 있음
    static let addButton = "추가"
}
