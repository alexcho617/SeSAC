//: [Previous](@previous)

import Foundation

//Property Wrapper
@propertyWrapper
struct MyDefaults<T>{
    let key: String
    let defaultValue: T
    
    var wrappedValue: T{
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
    
    //Property Wrapper
    @MyDefaults(key: Key.email.rawValue, defaultValue: "No Email")
    static var email
    
    @MyDefaults(key: Key.nickname.rawValue, defaultValue: "No Nickname")
    static var nickname
    
    @MyDefaults(key: Key.phone.rawValue, defaultValue: 12345)
    static var phone
}

UserDefaultsManager.email
UserDefaultsManager.email = "newemail@.com"
UserDefaultsManager.email

//Generic: Handle Different types
UserDefaultsManager.phone
UserDefaultsManager.phone = 1111
UserDefaultsManager.phone //myValue 까지 없애보자
//: [Next](@next)
