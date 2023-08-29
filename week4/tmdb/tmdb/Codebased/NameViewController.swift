//
//  NameViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit
//use closure
class NameViewController: BaseViewController {
    
    var completionHandler: ((String) -> Void)?
    
    let textField = {
        let view = UITextField()
        view.backgroundColor = .secondarySystemBackground
        view.placeholder = "이름을 입력하세요"
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

    }
    
    override func setView() {
        view.addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
        completionHandler?(textField.text!)
    }
    
}
