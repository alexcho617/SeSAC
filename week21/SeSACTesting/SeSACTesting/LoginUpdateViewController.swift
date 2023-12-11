//
//  OtherViewController.swift
//  SeSACTesting
//
//  Created by Alex Cho on 12/11/23.
//

import UIKit



class LoginUpdateViewController: UIViewController {
    let validator = Validator()
    var user = User(email: "", password: "", check: "")
    
    @IBOutlet weak var checkTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBAction func LoginClicked(_ sender: UIButton) {
        user = User(email: emailTextField.text!, password: passwordTextField.text!, check: checkTextField.text!)
        
        if validator.isValidEmail(email: user.email) &&
            validator.isValidPassword(password: user.password) &&
            validator.isSamePassword(password: user.password, check: user.check){
            print("Success")
        }else{
            print("Fail")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

struct User{
    let email: String
    let password: String
    let check: String
}

struct Validator{
    func isValidEmail(email: String) -> Bool {
        return email.contains("@") && email.count >= 6
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 6 && password.count < 10
    }
    
    func isSamePassword(password: String, check: String) -> Bool {
        return password == check
    }
}
