//: [Previous](@previous)

import Foundation

/*
 Guild and User cross reference
 */
class Guild {
    var name: String
    //weak: reference count올라감 방지
    weak var owner:  User?
//    unowned var owner:  User?
    
    
    init(name: String){
        self.name = name
        print("Guild Init")
    }
    
    deinit {
        print("Guild Deinit")
    }
    
}

class User{
    var nickname: String
    //weak: reference count올라감 방지
    weak var guild: Guild?
    init(nickname: String){
        self.nickname = nickname
        print("User Init")
        
    }
    
    deinit {
        print("User Deinit")
    }
}

var myUser: User? = User(nickname: "Ambit") //RC +1
var myGuild: Guild? = Guild(name: "Ambitious")//RC +1

myUser?.guild = myGuild //RC +1
myGuild?.owner = myUser //RC +1

print("Do stuff")

//circular reference
//deinit 불가
//이렇게 프로퍼티에 하나하나씩 nil로 설정하면 MRC를 쓰는것과 다를바가 없다.
//myUser?.guild = nil //RC-1
//myGuild?.owner = nil //RC-1

myUser = nil //RC -1
myGuild = nil// RC -1

//MARK: 이거에 대한 해결책으로 weak, unown 이 있다.
//weak: reference count올라감 방지

//weaak을 써도 어떠한 프로퍼티에 어떤 타이밍에 쓰는지에 따라 해제가 안될 수 있다.
//그래서 수명이 더 짧은 변수를 먼저 해제해주는 편이다.

//weak = RC가 안올라가게 했다. 그렇다면 unown은?
/*
 unown은 레퍼런스만 없애지 메모리까지 해제해주진 않는다.
 반면에 weak은 레퍼런스와 메모리까지 해제한다.
 그래서 보통은 weak을 많이 쓰는 편
 */

myGuild?.owner


//: [Next](@next)
