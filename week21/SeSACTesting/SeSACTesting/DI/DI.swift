//
//  DI.swift
//  SeSACTesting
//
//  Created by Alex Cho on 12/12/23.
//

import Foundation
//1 bran restaurant
//2 hue eats at the restaurant
//Changes in B class effects A class
//Hue(Upper Module) -> BransDiner(Lower Module) dependency means change in BranDiners effects Hue
//Lower Module's code change effects Upper Module.

// -> How to refrain Lower Module from affecting Upper Module? Protocol
//Bransdiner and kokosdiner conforms to the diner protocol
//Bran and kokojong conforms to the chefmenu protocol
// -> Depends on abstaction instead of instance
// -> Dependency abstaction with interface(protocol)

/*
 Init시점에 하위모듈을 주입하고
 DI 의존성 주입을 통해 객체의 생성과 사용을 분리한다.
 
 DI를 한다고해서 DIP를 준수하는것은 아니다. DIP를 구현하는 기법 중 하나가 DI이다
 
 구현체가 아닌 인터페이스 추상화에 의존한다
 */

protocol Diner{
    func lunchSpecial() -> String
}

protocol ChefMenu{
    func mainDish1() -> String
    func mainDish2() -> String
    func mainDish3() -> String
}

class Bran: ChefMenu{
    
    func mainDish1() -> String {
        "Crispy Juicy deep fried meat"
    }
    
    func mainDish2() -> String {
        "Warm and hearty souprice"
    }
    
    func mainDish3() -> String {
        "Chilling tasty bomber"
    }
    
}

class Kokojong: ChefMenu{
    func mainDish1() -> String {
        "Magical friend meat"
    }
    
    func mainDish2() -> String {
        "Just like your grandmas soup"
    }
    
    func mainDish3() -> String {
        "Kokos specialty"
    }
    
}

//Depends on Bran class
class BransDiner: Diner{
    //하위 모듈
    private var owner: ChefMenu!
    
    func lunchSpecial() -> String {
        return owner.mainDish1() + owner.mainDish2() + owner.mainDish3()
    }
}

class KokojongsDiner: Diner{
    //하위 모듈
    private var owner: Kokojong
    
    init(owner: Kokojong) {
        self.owner = owner
    }
    
    func lunchSpecial() -> String {
        return owner.mainDish1() + owner.mainDish2() + owner.mainDish3()
    }
}

//Depends on BransDiner, Kokojong's class -> Protocol을 타입으로 사용한 DI으로 변경됨

//BransDiner -> Diner, Bran -> ChefMenu.
//Hue-> Diner -> ChefMenu 클래스가 아닌 이제 프로토콜에 의존성을 가지고 있다.

//init을 쓰면 생성 시점과 사용을 분리한다 -> init을 통한 의존성 주입
class Hue{ //상위 모듈
    //Diner가 바뀌어도 코드에 영향이 없음
    var diner: KokojongsDiner
//    var diner: Diner!
    init(diner: KokojongsDiner) {
        self.diner = diner
    }
    
    func lunchMenu() -> String{
        diner.lunchSpecial()
    }
}

//MARK: DI 달성
//dependancy injection
let owner = Kokojong()
let kokodiner = KokojongsDiner(owner: owner)
let hue = Hue(diner: kokodiner)

//MARK: DIP
class KokojongsDinerDIP: Diner{
    //하위 모듈
    private var owner: ChefMenu!
    
    init(owner: ChefMenu) {
        self.owner = owner
    }
    
    func lunchSpecial() -> String {
        return owner.mainDish1() + owner.mainDish2() + owner.mainDish3()
    }
}
class HueDIP{ //상위 모듈
    var diner: Diner! //protocol
    init(diner: Diner) {
        self.diner = diner
    }
    
    func lunchMenu() -> String{
        diner.lunchSpecial()
    }
}

//MARK: DIP 사용시
//dependancy inversion
let dipOwner: ChefMenu = Kokojong()
let dipDiner: Diner = KokojongsDinerDIP(owner: dipOwner)
let dipHue = HueDIP(diner: dipDiner)


