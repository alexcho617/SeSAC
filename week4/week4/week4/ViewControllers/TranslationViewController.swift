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
    override func viewDidLoad() {
        super.viewDidLoad()
        sourcePickerView.delegate = self
        sourcePickerView.dataSource = self
        
        targetPickerView.delegate = self
        targetPickerView.dataSource = self
        
        sourceTextField.inputView = sourcePickerView
        targetTextField.inputView = targetPickerView

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
    
//    "Content-Type" : "application/x-www-form-urlencoded" Alamofire가 이미 처리
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "eJG7WB__DcOjqApdVE1E",
            "X-Naver-Client-Secret": APIKey.naverKey,
        ]
        let param: Parameters = [
            "source": source,
            "target": target,
            "text": originalTextView.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: param ,headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                self.translatedTextView.text = json["message"]["result"]["translatedText"].stringValue
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
