//
//  IdViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/30.
//

import UIKit

class IdViewController: BaseViewController {
    var delegate: PassDataDelegate?
    let textField = {
        let view = UITextField()
        view.backgroundColor = .secondarySystemBackground
        view.placeholder = "id를 입력하세요"
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
        delegate?.receiveData(data: textField.text!)

    }
}
