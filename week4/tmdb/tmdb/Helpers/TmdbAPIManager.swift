//
//  TmdbAPIManager.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import Foundation
import Alamofire
import SwiftyJSON

class TmdbAPIManager{
    static let shared = TmdbAPIManager()
    private init() {
        
    }
    
    func callTrendsRequest(type: Media, timeWindow: TimeWindow){
        let url = Endpoint.trend.requestURL + "\(type.rawValue)/\(timeWindow.rawValue)" + "?api_key=\(APIKey.tmdbKey)"
        print(url)
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func callCreditsRequest(of mediaId: Int){
        let url = Endpoint.credits.requestURL + "\(String(mediaId))/credits?api_key=\(APIKey.tmdbKey)"
        print(url)
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    569094/credits?api_key=\(APIKey.tmdbKey)
}
