//
//  LoginViewController.swift
//  first
//
//  Created by Alex Cho on 2023/07/19.
//

import UIKit
@available(iOS 13.0, *)

enum TextFieldType: Int{
    case id = 100,email = 200,password = 300
}
@available(iOS 13.0, *)
class LoginViewController: UIViewController {
    let userDefaults = UserDefaults.standard
    //outlets
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var idTextField: UITextField!
    
    
    @IBOutlet var toggleButton: UISwitch!
    
    
    
    
    
    @IBOutlet var signUpButton: UIButton!
    

    //viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //already assigns default value
        let testString = userDefaults.string(forKey: "wrongKey")
        let testInt = userDefaults.integer(forKey: "wrongKey")
        let testBool = userDefaults.bool(forKey: "wrongKey")
        
        print(testString, testInt, testBool) //nil 0 false

        setUpLoginScene()
        idTextField.tag = TextFieldType.id.rawValue
        
        emailTextField.tag = TextFieldType.email.rawValue
        
        passwordField.tag = TextFieldType.password.rawValue
        
        //load
        print("load")
        let id =  userDefaults.string(forKey: "id")
        let email = userDefaults.string(forKey: "email")
        let password = userDefaults.string(forKey: "password")
        
        if let id{
            idTextField.text = id
        }
        if let email{
            emailTextField.text = email
        }
        
        if let password{
            passwordField.text = password
        }
    }
    //actions
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        userDefaults.set(idTextField.text!, forKey: "id")
        userDefaults.set(emailTextField.text!, forKey: "email")
        userDefaults.set(passwordField.text!, forKey: "password")
        //get
        var val = userDefaults.integer(forKey: "count")
        //add
        val += 1
        //set
        userDefaults.set(val, forKey: "count")
        //check
        print(val)
    }
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
    }

    
    @IBAction func textFieldKeyboardTapped(_ sender: UITextField) {
        //가드 여러개쓰기
        //이거 혹시 논리 연산자 같은건 적용 못하나?
        guard let text = sender.text, let value = TextFieldType(rawValue: sender.tag) else{
            //알러트로 대응
            print("text empty")
            return
        }
        
//        guard let value = TextFieldType(rawValue: sender.tag) else{
//            print("Error no tag")
//            return
//        }
    
        switch value {
        case .email:
            print("email \(text)")
        case .id:
            print("id \(text)")
        case.password:
            print("password \(text)")
        }
        
//        sender tag 에서 에러 가능성있음
//        switch sender.tag {
//        case TextFieldType.id.rawValue:
//            print("아이디는 \(text)")
//
//        case TextFieldType.email.rawValue:
//            print("이메일은 \(text)")
//
//        case TextFieldType.password.rawValue:
//            print("비밀번호는 \(text)")
//
//        default:
//            print("Default")
//        }
    }
    
    @IBAction func gestureRecognizerTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func togglePressed(_ sender: UISwitch) {
        print(toggleButton.isOn)
    }
    
    
    //functions
    func setUpLoginScene(){
//        setTextFields()
        setSignUpButton()
        setSwitch()
    }
    
//    @available(iOS 13.0, *)
//    func setTextFields(){
//        let placeholderTexts = ["이메일","닉네임","위치","추천코드"]
//        for i in 0..<placeholderTexts.count{
//            userInformationFields[i].placeholder = placeholderTexts[i]
//            userInformationFields[i].textColor = .white
//            userInformationFields[i].textAlignment = .center
//            userInformationFields[i].borderStyle = .roundedRect
//            userInformationFields[i].backgroundColor = .systemGray3
//
//        }
//        //password field
//        passwordField.placeholder = "비밀번호"
//        passwordField.isSecureTextEntry = true
//        passwordField.textColor = .white
//        passwordField.borderStyle = .roundedRect
//        passwordField.textAlignment = .center
//        passwordField.backgroundColor = .systemGray3
//
//    }
    
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
