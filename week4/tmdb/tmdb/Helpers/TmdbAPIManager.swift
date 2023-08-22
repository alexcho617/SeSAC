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
    static let shared = TmdbAPIManager() //singleton
    
    private init() {}
    //images
    //backdrop: https://image.tmdb.org/t/p/w500/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg
    //poster: https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg
    
    func callTrendsRequest(type: MediaType, timeWindow: TimeWindow, completionHandler: @escaping (AFDataResponse<Trends>) -> ()){ //escaping closure of function type JSON -> ()
        let url = Endpoint.trend.requestURL + "\(type.rawValue)/\(timeWindow.rawValue)" + "?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate().responseDecodable(of: Trends.self) { response in
            completionHandler(response)
        }
    }
    
    func callCreditsRequest(of mediaId: Int, completionHandler: @escaping (AFDataResponse<Credits>) -> ()){
        let url = Endpoint.credits.requestURL + "\(String(mediaId))/credits?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate().responseDecodable(of: Credits.self) { response in
            completionHandler(response)
        }
        
    }
    
    func callRecommendRequest(of mediaId: Int, completionHandler: @escaping (AFDataResponse<Recommendation>) -> ()){
        let url = Endpoint.base.requestURL + "\(String(mediaId))/recommendations?api_key=\(APIKey.tmdbKey)"
        print(url)
        AF.request(url, method: .get).validate().responseDecodable(of: Recommendation.self) { response in
            switch response.result{
            case.success:
                completionHandler(response)
            case.failure(let error):
                print(error)
                print(url)
            }
            
            
        }
        
    }
    
    func callSimilarRequest(of mediaId: Int, completionHandler: @escaping (AFDataResponse<Similars>) -> ()){
        let url = Endpoint.base.requestURL + "\(String(mediaId))/similar?api_key=\(APIKey.tmdbKey)"
        print(url)
        AF.request(url, method: .get).validate().responseDecodable(of: Similars.self) { response in
            switch response.result{
            case.success:
                completionHandler(response)
            case.failure(let error):
                print(error)
                print(url)
            }        }
        
    }
    
}
