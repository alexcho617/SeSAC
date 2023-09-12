//
//  LoginViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)

        passwordTextField.addTarget(self, action: #selector(pwTextFieldChanged), for: .editingChanged)

        //Model -> VM -> View
        viewModel.id.bind { text in
            print("ID Bind",text)
            self.idTextField.text = text
        }
        viewModel.pw.bind { text in
            print("PW Bind",text)
            self.passwordTextField.text = text
        }
        //MARK: 판단 부분
        //VC는 VM이 주는 bool 값에 의해 판단한다. 
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .green : .gray
        }
    }
    
    func saveUD() async{
        sleep(1)
        print("UD Save")
    }
    
    func checkServer() async{
        sleep(1)
        print("Server Check")
        
    }
    func signIn() async{
        //Server 통신
        //UD 저장
        await checkServer()
        await saveUD()
        print("Signin")
    }
    
    
    //View -> VM -> Model
    @objc func idTextFieldChanged(){
        viewModel.id.value = idTextField.text!
        viewModel.pw.value = passwordTextField.text!
        viewModel.validate()
        
    }
    @objc func pwTextFieldChanged(){
        viewModel.id.value = idTextField.text!
        viewModel.pw.value = passwordTextField.text!
        viewModel.validate()
        
    }
    
    
    @objc func loginButtonClicked(){
        viewModel.login()
    }
    
//
//    @objc func loginButtonClicked() async {
//        await viewModel.signIn() //await 인데 이게 안되네
//    }
}
