//
//  IntroViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/30.
//

import UIKit

class IntroViewController: BaseViewController {
    let textField = {
        let view = UITextField()
        view.backgroundColor = .secondarySystemBackground
        view.placeholder = "자기소개를 입력하세요"
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
        NotificationCenter.default.post(name: NSNotification.Name("intro"), object: nil, userInfo: ["intro":textField.text])

    }
}
