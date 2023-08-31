//
//  TitleViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        view.backgroundColor = .gray
        return view
    }()
    
    
  
    //closure1: 전체 함수 타입을 감싸서 옵셔널로 만듬
    var completionHandler: ((String,Int,Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(#function, #file)

    }
    deinit {
        print("deinit", self)
    }
    override func configureView() {
        view.addSubview(textField)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneClicked))
        
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        
    }
    
    @objc func doneClicked(){
//        completionHandler?(textField.text!) // 이거 없어도 됨 근데 vDD에서 호출하면 좀 느림

        navigationController?.popViewController(animated: true)
        
    }
    
    //Closure 2
    override func viewDidDisappear(_ animated: Bool) {
        completionHandler?(textField.text!,3,false)
    }
    
}
