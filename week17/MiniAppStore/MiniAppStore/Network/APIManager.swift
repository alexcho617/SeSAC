//
//  APIManager.swift
//  MiniAppStore
//
//  Created by Alex Cho on 2023/11/07.
//

import Foundation
import RxSwift
import Alamofire

enum APIError: Error{
    case invalidURL
    case serverError
    case statusError
}

class APIManager{
    static func fetchData(query: String) -> Observable<AppstoreModel>{
        return Observable<AppstoreModel>.create {value in
            let urlString = "https://itunes.apple.com/search?country=KR&media=software&lang=ko_KR&limit=10"
            var urlComponents = URLComponents(string: urlString)
            //한국어 처리
            let termQuery = URLQueryItem(name: "term", value: query)
            urlComponents?.queryItems?.append(termQuery)
            
            guard let url = urlComponents?.url else {
                value.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            let request = URLRequest(url: url, timeoutInterval: 5.0)
            URLSession.shared.dataTask(with: request) { data,response,error in
                print("URLSession")
                if let _ = error {
                    print("Error",APIError.serverError)
                    value.onError(APIError.serverError)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Error", APIError.statusError)
                    value.onError(APIError.statusError)
                    return
                }
                
                
                if let data, let decodedData = try? JSONDecoder().decode(AppstoreModel.self, from: data){
                    value.onNext(decodedData)
                }
            }.resume()
            
            return Disposables.create()
        }
    }
}
