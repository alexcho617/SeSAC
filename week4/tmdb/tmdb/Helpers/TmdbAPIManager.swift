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
    //images
    //backdrop: https://image.tmdb.org/t/p/w500/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg
    //poster: https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg
    
    func callTrendsRequest(type: MediaType, timeWindow: TimeWindow, completionHandler: @escaping (JSON) -> ()){ //escaping closure of function type JSON -> ()
        let url = Endpoint.trend.requestURL + "\(type.rawValue)/\(timeWindow.rawValue)" + "?api_key=\(APIKey.tmdbKey)"
        print(url)
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func callCreditsRequest(of mediaId: Int, completionHandler: @escaping (JSON) -> ()){
        let url = Endpoint.credits.requestURL + "\(String(mediaId))/credits?api_key=\(APIKey.tmdbKey)"
        print(url)
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
