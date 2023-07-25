//
//  LoginViewController.swift
//  first
//
//  Created by Alex Cho on 2023/07/19.
//

import UIKit
@available(iOS 13.0, *)
class LoginViewController: UIViewController {

    //outlets
    @IBOutlet var userInformationFields: [UITextField]!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var toggleButton: UISwitch!
    
    @IBOutlet var signUpButton: UIButton!
    

    //viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLoginScene()
        // Do any additional setup after loading the view.
    }
    
    
    //actions
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    
    @IBAction func gestureRecognizerTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func togglePressed(_ sender: UISwitch) {
        print(toggleButton.isOn)
    }
    
    
    //functions
    @available(iOS 13.0, *)
    func setUpLoginScene(){
        setTextFields()
        setSignUpButton()
        setSwitch()
    }
    
    @available(iOS 13.0, *)
    func setTextFields(){
        let placeholderTexts = ["이메일","닉네임","위치","추천코드"]
        for i in 0..<placeholderTexts.count{
            userInformationFields[i].placeholder = placeholderTexts[i]
            userInformationFields[i].textColor = .white
            userInformationFields[i].textAlignment = .center
            userInformationFields[i].borderStyle = .roundedRect
            userInformationFields[i].backgroundColor = .systemGray3
                    
        }
        //password field
        passwordField.placeholder = "비밀번호"
        passwordField.isSecureTextEntry = true
        passwordField.textColor = .white
        passwordField.borderStyle = .roundedRect
        passwordField.textAlignment = .center
        passwordField.backgroundColor = .systemGray3
        
    }
    
    func setSignUpButton(){
        signUpButton.titleLabel?.text = "회원가입"
        signUpButton.tintColor = .black
    }
    
    func setSwitch(){
        let toggleValue = toggleButton.isOn
        toggleButton.setOn(toggleValue, animated: true)
        toggleButton.onTintColor = .systemYellow
        toggleButton.thumbTintColor = .systemRed
        
    }

}
