//: [Previous](@previous)

import Foundation

class User{
    let nickname = "Alex"
    lazy var intro: () -> String = { [weak self] in //weak capture로 변경
        //self 는 캡쳐 -> 변수 생명주기가 끝나도 다른 곳에 저장
        //Closure Capturelist, Context
        return "Hi \(self?.nickname)"
    }
    
    init(){
        print("User Init")
    }
    deinit {
        print("USer Deinit")
    }
}

var myUser: User? = User()
let intro = myUser?.intro

print(intro!())
myUser = nil //deinit

print(intro!())

//: [Next](@next)
