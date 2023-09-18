//
//  ViewController.swift
//  mvvm-netflix
//
//  Created by Alex Cho on 2023/09/18.
//

import UIKit
import SnapKit
enum LoginStatus: String, CaseIterable{
    case emailError = "올바른 이메일을 입력하세요"
    case passwordError = "비밀번호는 6~10자리입니다"
    case referalError = "추천코드는 6자리입니다"
    case success = "로그인 성공"
}
class LoginViewController: UIViewController {
    let vm = LoginViewModel()
    var emailCheck = Observable("")
    var passwordCheck = Observable("")
    var referCheck = Observable("")
    
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 48)
        label.textColor = .red
        label.text = "ALFLIX"
        return label
    }()
    
    let email = CustomGrayTextField(placeholder: "이메일")
    let emmailLabel = {
        let view = UILabel()
        view.textColor = .systemRed
        view.text = LoginStatus.emailError.rawValue
        return view
    }()

    let password = CustomGrayTextField(placeholder: "비밀번호", isSecureText: true)
    let passwordLabel = {
        let view = UILabel()
        view.textColor = .systemRed
        view.text = LoginStatus.passwordError.rawValue
        return view
    }()

    let nickname = CustomGrayTextField(placeholder: "닉네임")
    let location = CustomGrayTextField(placeholder: "위치")
    
    let refer = CustomGrayTextField(placeholder: "추천 코드 입력")
    let referLabel = {
        let view = UILabel()
        view.textColor = .systemRed
        view.text = LoginStatus.referalError.rawValue
        return view
    }()

    lazy var stackView = {
        lazy var view = UIStackView(arrangedSubviews: [self.email,self.emmailLabel, self.password,self.passwordLabel, self.nickname, self.location, self.refer, self.referLabel])
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    let signUpButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let additional = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let switchButton = {
        let view = UISwitch()
        view.onTintColor = .red
        view.tintColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
    }
    
    private func setView(){
        view.backgroundColor = .black
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(signUpButton)
        view.addSubview(additional)
        view.addSubview(switchButton)
        signUpButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        
        email.delegate = self
        password.delegate = self
        refer.delegate = self

        emailCheck.bind { value in
            self.emmailLabel.isHidden = self.vm.validateEmail(value) ? true : false
        }
        passwordCheck.bind { value in
            self.passwordLabel.isHidden = self.vm.validatePW(value) ? true : false
        }
        referCheck.bind { value in
            self.referLabel.isHidden = self.vm.validateRefer(value) ? true : false
        }
        
    }
    private func setConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(40)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(view).multipliedBy(0.45)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(40)
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        
        additional.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(40)
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
        }
        
        switchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
        }
    }
    
    @objc func registerButtonClicked(){
        vm.id = email.text
        vm.pw = password.text
        vm.nickname = nickname.text
        vm.location = location.text
        vm.refer = refer.text

        let status = vm.login()

        showAlert(title: "로그인", status: status)
        
    }
    
    
    func showAlert(title: String, status: LoginStatus){
        let alert = UIAlertController(title: title, message: status.rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { action in
            if status == .success{
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            }
        }
        alert.addAction(action)
        present(alert,animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == email{
            emailCheck.value = textField.text ?? ""
        }
        else if textField == password{
            passwordCheck.value = textField.text ?? ""
        }
        else if textField == refer{
            referCheck.value = textField.text ?? ""
        }
        
        return true
    }
}
