//: [Previous](@previous)
//Enum and Computed Property
import Foundation

//열거형은 인스턴스 생성 불가. 인스턴스 프로퍼티, 인스턴스 메소드 사용 불가
enum UserDefaultsManager{
    
    //Compile Optimization
    enum Key: String{
        case email
        case nickname
        case phone
    }
    
    //Type Property
    static var email: String{
        get{
            UserDefaults.standard.string(forKey: Key.email.rawValue) ?? "No Email"
        }
        set{
            UserDefaults.standard.set(newValue, forKey: Key.email.rawValue)
        }
    }
    
    static var nickname: String{
        get{
            UserDefaults.standard.string(forKey: Key.nickname.rawValue) ?? "No Nickname"
        }
        set{
            UserDefaults.standard.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    static var phone: String{
        get{
            UserDefaults.standard.string(forKey: Key.phone.rawValue) ?? "No phone"
        }
        set{
            UserDefaults.standard.set(newValue, forKey: Key.phone.rawValue)
        }
    }
    
}
//let manager = UserDefaultsManager()
//manager.email
//


UserDefaultsManager.email
UserDefaultsManager.nickname
UserDefaultsManager.phone
UserDefaultsManager.email = "4@4.com"

print("my email is \(UserDefaultsManager.email)")
//: [Next](@next)

