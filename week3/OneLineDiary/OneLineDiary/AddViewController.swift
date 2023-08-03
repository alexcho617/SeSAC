//
//  AddViewController.swift
//  OneLineDiary
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit
enum TransitionType: String{
    case add =  "추가 화면"
    case edit = "수정 화면"
}

class AddViewController: UIViewController, UITextViewDelegate {
    var transitionType: TransitionType = .add
    var contents: String?
    //placeholder
    let placeholderText = "Begin Enter"

    @IBOutlet weak var contentsTextView: UITextView!
    
    @IBOutlet weak var wordCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //임시저장 같은 기능들을 구현할 수 있다
        contentsTextView.delegate = self
      
        //x button 을 보여줄껀가 말껀가
        switch transitionType {
        case .add: //full screen need x button
            title = "추가"
            contentsTextView.text = placeholderText
            contentsTextView.textColor = .secondaryLabel
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
            
            
            navigationItem.leftBarButtonItem?.tintColor = .black
            
        
        case .edit: //dont need x button
            title = "수정"
            if let contents{
                contentsTextView.text = contents
            }
        }
        setBackgroundColor()
    }
    
    @IBAction func tapRecognized(_ sender: UITapGestureRecognizer) {
        print("TAP")
        view.endEditing(true)
    }
    
    
    //내용이 바뀔때마다
    func textViewDidChange(_ textView: UITextView) {
        wordCountLabel.text = String(textView.text.count)
    }
    
    //편집시작 , 커서가 생김
    //플레이스홀더와 텍스트뷰 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.text == placeholderText{
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝남 커서가 없어짐
    //아무 글자도 안섰ㅇ면 플레이스홀더 글자 봉게 설정
    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
        if textView.text.isEmpty{
            textView.text = placeholderText
            textView.textColor = .secondaryLabel
        }
    }
    
    
    @objc
    func plusButtonClicked(){
        //present - dismiss
        print("add")
        
//        DiaryTableViewController.list.append(contentsTextView.text)
        
//        dismiss(animated: true)
    }
    @objc
    func closeButtonClicked(){
        //present - dismiss
        view.endEditing(true)
        dismiss(animated: true)
    }
}
