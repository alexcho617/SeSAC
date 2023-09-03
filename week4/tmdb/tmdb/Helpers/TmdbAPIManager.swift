//
//  TmdbAPIManager.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class TmdbAPIManager{
    static let shared = TmdbAPIManager() //singleton
    
    private init() {}
    //images
    //backdrop: https://image.tmdb.org/t/p/w500/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg
    //poster: https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg
    
    func callTrendsRequest(type: MediaType, timeWindow: TimeWindow, completionHandler: @escaping (AFDataResponse<Trends>) -> ()){ //escaping closure of function type JSON -> ()
        let url = Endpoint.trend.requestURL + "\(type.rawValue)/\(timeWindow.rawValue)" + "?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate().responseDecodable(of: Trends.self) { response in
            switch response.result{
            case.success:
                completionHandler(response)
            case.failure(let error):
                completionHandler(response)
                print(#function, error, "ALERT")
            }
        }
    }
    
    func callTrendsRequestWithURLSession(type: MediaType, timeWindow: TimeWindow, completionHandler: @escaping (Trends) -> Void){
        let urlString = Endpoint.trend.requestURL + "\(type.rawValue)/\(timeWindow.rawValue)" + "?api_key=\(APIKey.tmdbKey)"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error{
                print(error)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else{
                print("response error")
                return
            }
            
            guard let data = data else {
                print("data error")
                return
            }
            
            do{
                let result = try JSONDecoder().decode(Trends.self, from:data)
                completionHandler(result)
            }
            catch{
                print("decode error")
                return
            }
        }.resume()
    }
    func callCreditsRequest(of mediaId: Int, completionHandler: @escaping (AFDataResponse<Credits>) -> ()){
        let url = Endpoint.credits.requestURL + "\(String(mediaId))/credits?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate().responseDecodable(of: Credits.self) { response in
            switch response.result{
            case.success:
                completionHandler(response)
            case.failure(let error):
                completionHandler(response)
                print(#function, error, "ALERT")
            }
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
                print(#function, error, "ALERT")
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
                print(#function, error, "ALERT")
            }
        }
        
    }
    
 
}

