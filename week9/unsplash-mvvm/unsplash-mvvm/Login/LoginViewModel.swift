//
//  LoginViewModel.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/12.
//

import Foundation

class LoginViewModel{
    var id = Observable("")
    var pw = Observable("")
    var isValid = Observable(false)
    
    func validate(){
        print(#function)
        if id.value.count >= 6 && pw.value.count >= 4{
            isValid.value = true
        }else {
            isValid.value = false
        }
    }
    
    var login: (() -> Void) = {
        print("view model login")
    }
    
}
