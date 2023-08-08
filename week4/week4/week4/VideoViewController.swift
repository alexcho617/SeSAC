//
//  VideoViewController.swift
//  week4
//
//  Created by Alex Cho on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
class VideoViewController: UIViewController {
    
    var videoList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        
    }
    
    
    func callRequest(){
        let headers: HTTPHeaders = ["Authorization":APIKey.kakaoKey]
        let text = "아이유".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)"

        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["documents"].arrayValue{
                    self.videoList.append(item["title"].stringValue)
                }
                print("JSON: \(json)")
                print(self.videoList)
            case .failure(let error):
                print(error)
            }
        }
    }

}
