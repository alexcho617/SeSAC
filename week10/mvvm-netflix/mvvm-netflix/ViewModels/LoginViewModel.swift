//
//  LoginViewModel.swift
//  mvvm-netflix
//
//  Created by Alex Cho on 2023/09/18.
//

import Foundation

class LoginViewModel{
    var id: String?
    var pw: String?
    var nickname: String?
    var location: String?
    var refer: String?
    
    func validateEmail(_ id: String?) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    func validatePW(_ pw: String?) -> Bool{
        guard let pw = pw else { return false }
        if 6 <= pw.count && pw.count <= 10{
            return true
        }
        return false
    }
    func validateRefer(_ refer: String?) -> Bool{
        guard let refer = refer else { return false }
        if refer.count == 6 {
            return true
        }
        return false
    }
    
 
    func login() -> LoginStatus{
        if !validateEmail(self.id){
            return .emailError
        }
        if !validatePW(self.pw){
            return .passwordError
        }
        if !validateRefer(self.refer){
            return .referalError
        }
        
        return .success
    }
}

