//
//  myViewModel.swift
//  combine-textfield-tutorial
//
//  Created by Alex Cho on 2023/09/19.
//

import Foundation
import Combine

class MyViewModel{
    @Published var pwInput: String = ""{
        didSet{
//            print("ViewModel / pwInput: \(pwInput)")
        }
    }
    @Published var pwInputCheck: String = ""{
        didSet{
//            print("ViewModel / pwInputCheck: \(pwInputCheck)")
        }
    }
    
    lazy var isPasswordMatch: AnyPublisher<Bool, Never> = Publishers.CombineLatest($pwInput,$pwInputCheck)
        .map({ (password: String, passwordConfirm: String) in
            if password == "" || passwordConfirm == ""{
                return false
            }
            if password == passwordConfirm{
                return true
            }else{
                return false
            }
        })
        .print()
        .eraseToAnyPublisher()
    
}
