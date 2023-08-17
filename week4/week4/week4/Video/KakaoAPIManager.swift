//
//  KakaoAPIManager.swift
//  week4
//
//  Created by Alex Cho on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class KakaoAPIManager{
    static let shared = KakaoAPIManager()
    private init() {
        
    }
    let headers: HTTPHeaders = ["Authorization":APIKey.kakaoKey]
    let size = 20
    
    func callRequest(type: Endpoint, query: String, completionHandler: @escaping (VideoSearch) -> () ){
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! //convert korean to url? ascii? UTF?
        let url = type.requestURL + text
        print(url)
        AF.request(url, method: .get, headers: headers).validate(statusCode: 200...500).responseDecodable(of: VideoSearch.self) { response in
            switch response.result{
            case .success(let value):
                completionHandler(value)
            
            case .failure(let error):
                print(error)
            }
        }
    }
}
