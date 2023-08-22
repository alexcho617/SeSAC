//
//  OneViewController.swift
//  week6-assign
//
//  Created by Alex Cho on 2023/08/22.
//

import UIKit
import SnapKit
class OneViewController: UIViewController {
    let titleTextField = getTextField(placeholder: "제목을 입력하세요")
    let dateTextField = getTextField(placeholder: "날짜를 입력하세요")
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.image = UIImage(systemName: "person")
        return view
    }()
    
    let contentTextView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        view.text = "내용을 입력하세요"
        return view
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(titleTextField)
        view.addSubview(dateTextField)
        view.addSubview(contentTextView)
        super.viewDidLoad()
        configureLayout()
    }
    
   
    
    func configureLayout(){
        let inset = 20
        let textFieldHeight = 50
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(inset)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(inset)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(inset)
            make.height.equalTo(textFieldHeight)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(inset)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(inset)
            make.height.equalTo(textFieldHeight)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(inset)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(inset)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    static func getTextField(placeholder: String) -> UITextField{
        let view = UITextField()
        view.textAlignment = .center
        view.placeholder = placeholder
        view.layer.borderWidth = 2
        view.backgroundColor = .white
        
        return view
    }
}
