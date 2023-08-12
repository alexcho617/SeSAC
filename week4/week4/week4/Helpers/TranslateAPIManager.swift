//
//  TranslateAPIManager.swift
//  week4
//
//  Created by Alex Cho on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class TranslateAPIManager{
    static let shared = TranslateAPIManager()
    private init() {
        
    }
    
    func callRequest(source: String, target: String, text: String, resultString: @escaping (String) -> Void){
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "eJG7WB__DcOjqApdVE1E",
            "X-Naver-Client-Secret": APIKey.naverKey,
        ]
        let param: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: param ,headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let data = json["message"]["result"]["translatedText"].stringValue
                print(data)
                resultString(data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
