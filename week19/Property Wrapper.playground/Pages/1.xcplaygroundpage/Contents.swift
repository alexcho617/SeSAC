//: [Previous](@previous)
//Basic
import Foundation
enum Key: String {
    case email, nickname, phone
}
UserDefaults.standard.set("Alex@sesac.com", forKey: Key.email.rawValue)
UserDefaults.standard.set("alex", forKey: Key.nickname.rawValue)
UserDefaults.standard.set("1234", forKey: Key.phone.rawValue)

UserDefaults.standard.string(forKey: Key.email.rawValue)
UserDefaults.standard.string(forKey: Key.nickname.rawValue)
UserDefaults.standard.string(forKey: Key.phone.rawValue)

UserDefaults.standard.set("Blex@sesac.com", forKey: Key.email.rawValue)
UserDefaults.standard.set("blex", forKey: Key.nickname.rawValue)
UserDefaults.standard.set("2222", forKey: Key.phone.rawValue)

let email = UserDefaults.standard.string(forKey: Key.email.rawValue)
print("my email is \(email)")
UserDefaults.standard.string(forKey: Key.nickname.rawValue)
UserDefaults.standard.string(forKey: Key.phone.rawValue)
//: [Next](@next)
