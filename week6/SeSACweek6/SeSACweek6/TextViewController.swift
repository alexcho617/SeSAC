//
//  TextViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/22.
//

import UIKit
import SnapKit
class TextViewController: UIViewController {
    
    //closure: unnamed method with call
    //재사용이 떨어지지만 한곳에서만 쓸 경우 용이
    let imageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    let titleTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.placeholder = "Enter Text"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 12)
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1
//        view.addSubview(imageView)
//        view.addSubview(titleTextField)
        
        
        //2
//        for item in [imageView,titleTextField]{
//            view.addSubview(item)
//        }
        
        //3
        let views = [imageView,titleTextField]
        //closure
        views.forEach { view.addSubview($0) }
        
        setUpConstraints()
    }
    
    fileprivate func setUpConstraints() {
        
        
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20) //imageview 기준으로 잡기 때문에 imageview 먼저 실행해야함
            make.leadingMargin.equalTo(20) //make.leading.equalTo(view).inset(20) 같음
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}
