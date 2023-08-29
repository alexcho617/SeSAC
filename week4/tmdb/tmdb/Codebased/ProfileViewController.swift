//
//  ProfileViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit
enum ButtonType{
    case profile,intro,id
}
class ProfileViewController: BaseViewController {
   
    
    let nameButton = {
       let view = UIButton()
        view.backgroundColor = .red
        view.setTitle("홍길동", for: .normal)
        return view
    }()
    
    let introButton = {
       let view = UIButton()
        view.backgroundColor = .orange
        view.setTitle("안녕하세요. 반갑습니다.", for: .normal)
        return view
    }()
    
    let idButton = {
        let view = UIButton()
        view.backgroundColor = .green
         view.setTitle("thisIsMyID", for: .normal)
         return view
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(introObserver), name: NSNotification.Name("intro"), object: nil)

    }
    
    override func setView() {
        view.addSubview(nameButton)
        view.addSubview(introButton)
        view.addSubview(idButton)
        nameButton.addTarget(self, action: #selector(nameClicked), for: .touchUpInside)
        introButton.addTarget(self, action: #selector(introClicked), for: .touchUpInside)
        idButton.addTarget(self, action: #selector(idClicked), for: .touchUpInside)
    }
    
    @objc func nameClicked(){
        let vc = NameViewController()
        
        //Closure
        vc.completionHandler = { value in
            self.nameButton.setTitle(value, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func introClicked(){
        print(#function)

        navigationController?.pushViewController(IntroViewController(), animated: true)
    }
    
    //Notification
    @objc func introObserver(notification: NSNotification){
        guard let intro = notification.userInfo?["intro"] as? String else {return}
        introButton.setTitle(intro, for: .normal)
    }
    
    
    //Delegate
    @objc func idClicked(){
        print(#function)
        let vc = IdViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)

    }
    
    override func setConstraints() {
        nameButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        introButton.snp.makeConstraints { make in
            make.top.equalTo(nameButton.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        idButton.snp.makeConstraints { make in
            make.top.equalTo(introButton.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}


extension ProfileViewController: PassDataDelegate{
    func receiveData(data: String) {
        idButton.setTitle(data, for: .normal)
    }
}
