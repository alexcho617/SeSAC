//
//  TranslationViewController.swift
//  week4
//
//  Created by Alex Cho on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var sourceTextField: UITextField!
    
    @IBOutlet weak var targetTextField: UITextField!
    
    @IBOutlet weak var originalTextView: UITextView!
    
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var translatedTextView: UITextView!
    
    private var languages = ["한국어", "영어", "일본어", "중국어 간체", "중국어 번체","베트남어"]
    private var langCode = ["ko","en","ja","zh-CN","zh-TW","vi"]
    let sourcePickerView = UIPickerView()
    let targetPickerView = UIPickerView()
    var source: String = "ko"
    var target: String = "en"
  /// Singleton pattern
//    let helper = UserDefaultHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        sourcePickerView.delegate = self
        sourcePickerView.dataSource = self
        
        targetPickerView.delegate = self
        targetPickerView.dataSource = self
        
        sourceTextField.inputView = sourcePickerView
        targetTextField.inputView = targetPickerView
        
        configureView()
//
//        //before refactoring
//        UserDefaults.standard.set("Alex", forKey: "nickname")
//        UserDefaults.standard.set(12, forKey: "age")
//
//        UserDefaults.standard.string(forKey: "nickname")
//        UserDefaults.standard.integer(forKey: "age")
//
//        //after refactoring
//        UserDefaultHelper.standard.nickname = "alex"
//        UserDefaultHelper.standard.age = 14
//
//        print(UserDefaultHelper.standard.nickname)
//        print(UserDefaultHelper.standard.age)
//
    }
    
    func configureView(){
        source = langCode[0]
        sourceTextField.text = languages[0]
        target = langCode[1]
        targetTextField.text = languages[1]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sourcePickerView{
            source = langCode[row]
            sourceTextField.text = languages[row]
        }else if pickerView == targetPickerView{
            target = langCode[row]
            targetTextField.text = languages[row]
        }
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        TranslateAPIManager.shared.callRequest(source: source, target: target, text: originalTextView.text ?? ""){ result in
            self.translatedTextView.text = result
        }
    }
    
}
