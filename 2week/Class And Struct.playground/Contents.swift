import UIKit

protocol Boss{
    func ultimate()
}

class Monster{
    let exp, speed, power : Int
    let clothes: String
    
    //init with default value
    init(exp: Int = 1, clothes: String = "none", speed: Int = 1, power: Int = 1) {
        self.exp = exp
        self.clothes = clothes
        self.speed = speed
        self.power = power
    }
    
    func attack(){
        print("monster attacks")
    }
    
    func isHit(){
        print("monster is hit")
    }
}

class BossMonter: Monster,Boss{
    var specialItem: String
    
    init(exp: Int = 1, clothes: String = "none", speed: Int = 1, power: Int = 1, specialItem: String) {
            self.specialItem = specialItem
            super.init(exp: exp, clothes: clothes, speed: speed, power: power)
        }
    
    
    
    
    func ultimate() {
        print("BOSS ULTIMATE")
    }
    
    override func attack() {
        super.attack() //parent class
        print("boss attacks")
    }
//  super.function()을 통해서 상속받은 부모의 기능도 동시에 실행을 하는것.
//    override func viewDidLoad9){
//        super.viewDidLoad()
//        print("my viewdidload")
//    }
//
    
    override func isHit() {
        if self.speed > 3{
            print("MISS: Boss is too quick to hit")
        }else{
            print("HIT: Boss is slow enough to hit")
        }
    }
    
    
}

var monster = Monster(exp: 1, clothes: "red", speed: 2, power: 2)
var bossMonster = BossMonter(exp: 10, clothes: "black", speed: 2, power: 10, specialItem: "sword of griffindor")

monster.attack()
monster.isHit()


bossMonster.attack()
bossMonster.isHit()
bossMonster.ultimate()
print(bossMonster.specialItem)
