import UIKit

struct User{
    var name = "Alex"//instance property
    static let originalName = "Sungjin" //type property
}

User.originalName
User().name

//String은 인스턴스의(ex.Alex) 타입
//"고래밥" -> String
//String -> String.Type

//User() -> User
//User -> User.Type
type(of: User().name)
type(of: User())

type(of: User()).originalName
//구조체나 타입 그 자체를 메타 타입이라고 한다
//type of type is metatype

/*
 MetaType 그 자체는 User.Type
 MetaType의 값은 User.self
 이걸 생략해서 사용해왔다.
 */

User.originalName
User.self.originalName

//instance
let number: Int = 8.self

//structure itself
let result: Int.Type = Int.self
