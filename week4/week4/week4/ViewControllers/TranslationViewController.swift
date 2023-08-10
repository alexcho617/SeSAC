//
//  TranslationViewController.swift
//  week4
//
//  Created by Alex Cho on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslationViewController: UIViewController {
    
    @IBOutlet weak var originalTextView: UITextView!
    
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var translatedTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
//    "Content-Type" : "application/x-www-form-urlencoded" Alamofire가 이미 처리
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "eJG7WB__DcOjqApdVE1E",
            "X-Naver-Client-Secret": APIKey.naverKey,
        ]
        let param: Parameters = [
            "source": "ko",
            "target": "en",
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
