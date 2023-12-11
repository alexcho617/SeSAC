//
//  LoginViewController.swift
//  SeSACTesting
//
//  Created by Alex Cho on 12/11/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var checkTextField: UITextField!
    
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        
        if isValidEmail() && isValidPassword() && isSamePassword(){
            print("Success")
        }else{
            print("Fail")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func isValidEmail() -> Bool {
        guard let check = emailTextField.text else {
            return false
        }
        
        return check.contains("@") && check.count >= 6
    }
    
    func isValidPassword() -> Bool {
        guard let check = passwordTextField.text else {
            return false
        }
        return check.count >= 6 && check.count < 10
    }
    
    func isSamePassword() -> Bool {
        guard let password = passwordTextField.text,
              let check = checkTextField.text else {
                  return false
              }
        return password == check
    }

}
