//
//  TextViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit

class TextViewController: BaseViewController {
    let textView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        view.text = "내용을 입력해주세요"
        return view
    }()
    
    var completionHandler: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(150)
        }
    }
    
    override func configureView() {
        view.addSubview(textView)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        completionHandler?(textView.text!)

    }
    
    
    
    
    
    
}
