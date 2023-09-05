//
//  BookDetailViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift
class BookDetailViewController: UIViewController {
    var book: RealmBook?
    let realm = try! Realm()
    
    let titleTextField = {
        let view = UITextField()
        view.backgroundColor = .systemGray
        view.placeholder = "제목"
        
        return view
    }()
    
    let memoTextView = {
        let view = UITextView()
        view.backgroundColor = .systemGray
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
        setConstraints()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveClicked))

    }

    @objc func saveClicked(){
        print(#function)
        //realm update
        if let book{
            let item = RealmBook(value: [
                "_id":book._id,
                "title": titleTextField.text!,
                "thumbnail":book.thumbnail,
                "url":book.url,
                "isLiked":book.isLiked,
                "memo": memoTextView.text
            ])
            
            do {
                try realm.write{
                    realm.add(item, update: .modified)
                }
            } catch let error {
                print(error)
            }
        }
        
        //pop
        navigationController?.popViewController(animated: true)
    }
    
    func setConstraints(){
        titleTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.centerX.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
    }
    func setView(){
        view.addSubview(titleTextField)
        view.addSubview(memoTextView)
        titleTextField.text = book?.title
        memoTextView.text = book?.memo

    }
    
}
