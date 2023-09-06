//
//  DetailViewController.swift
//  PhotoGramRealm
//
//  Created by Alex Cho on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift
class DetailViewController: BaseViewController {
    let repository = DiaryTableRepository()
    var diary: Diary?
    let titleTextField: WriteTextField = {
        let view = WriteTextField()
        view.textColor = Constants.BaseColor.text
        view.attributedPlaceholder = NSAttributedString(string: "제목을 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor : Constants.BaseColor.placeholder])
        
        
        return view
    }()
    
    let contentTextField: WriteTextField = {
        let view = WriteTextField()
        view.textColor = Constants.BaseColor.text
        view.attributedPlaceholder = NSAttributedString(string: "내용을 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor : Constants.BaseColor.placeholder])
        
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.center.equalTo(view)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(60)
        }
    }
    
    @objc func editButtonClicked(){
        //Realm update
        guard let diary = diary else {return}
        
        repository.update(id: diary._id, title: titleTextField.text!, contents: contentTextField.text!)
        navigationController?.popViewController(animated: true)
        
        
    }
    override func configure() {
        super.configure()
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonClicked))
        bindData()
    }
    
    
    
    func bindData(){
        if let diary{
            titleTextField.text = diary.title
            contentTextField.text = diary.contents
        }
    }
    
}
