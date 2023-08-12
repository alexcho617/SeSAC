//
//  UserDefaultHelper.swift
//  week4
//
//  Created by Alex Cho on 2023/08/11.
//

import Foundation

class UserDefaultHelper{
    static let standard = UserDefaultHelper()
    private init(){
        
    }
    
    
    private enum Key: String{
        case nickname
        case age
        
    }
    
    
    let userDefaults = UserDefaults.standard
    var nickname: String{
        get{
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? ""
        }
        set{
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int{
        get{
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set{
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
