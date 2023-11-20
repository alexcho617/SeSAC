//: [Previous](@previous)
//Struct Abstraction and Generic
import Foundation

//Instance Property
struct MyDefaults<T>{
    let key: String
    let defaultValue: T
    
    var myValue: T{
        get{
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue //object method for generic
        }
        set{
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

enum UserDefaultsManager{
    //Compile Optimization
    enum Key: String{
        case email
        case nickname
        case phone
    }
    
    //Type Property
    static var email = MyDefaults(key: Key.email.rawValue, defaultValue: "No Email")
    static var nickname = MyDefaults(key: Key.nickname.rawValue, defaultValue: "No nickname")
    static var phone = MyDefaults(key: Key.phone.rawValue, defaultValue: 123123)
}

UserDefaultsManager.email.myValue
UserDefaultsManager.email.myValue = "newemail@.com"
UserDefaultsManager.email.myValue

//Generic: Handle Different types
UserDefaultsManager.phone.myValue
UserDefaultsManager.phone.myValue = 1111
UserDefaultsManager.phone.myValue //myValue 까지 없애보자
//: [Next](@next)
