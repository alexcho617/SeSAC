//
//  APIService.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/30.
//

import Foundation
import Alamofire

class APIService{
    private init(){}
    static let shared = APIService()
//    func callRequestWithURLSession(){
//    //"https://www.apple.com/105/media/us/apple-events/2023/ad6b79de-2819-4715-be4e-c9f1488ab703/anim/large_2x.mp4" 7메가 바이트
//        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg") //1.5메가바이트
//        let request = URLRequest(url: url!)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            print(data)
//            let value = String(data: data!, encoding: .utf8)
//            print(value)
////            print(response)
//            print(error)
//        }.resume() //이게 있어야 시작
//    }
    
//https://api.unsplash.com/search/photos?query={query}&client_id={key}
    func callRequestWithAF(query: String, completionHandler: @escaping (AFDataResponse<Unsplash>) ->()){
        let url = Endpoint.search.requestURL + query + "&client_id=" + APIKey.unsplash
        print("URL",url)
        
        AF.request(url, method: .get).validate().responseDecodable(of: Unsplash.self) { response in
            switch response.result{
            case .success:
                completionHandler(response)
            case .failure(let error):
                print(#function, error)
            }
        }
    }
    
    
    func callRequestWithURLSession(query: String, completionHandler: @escaping (Photo?) -> Void){
        let urlString = Endpoint.search.requestURL + query + "&client_id=" + APIKey.unsplash
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url, timeoutInterval: 5)
        //내부적으로 Global Queue임으로 완료 후 UI 업데이트시 Main Queue에서 실행
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completionHandler(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                completionHandler(nil)
                return
            }
            
            guard let data = data else {
                completionHandler(nil)
                return
            }
            
            do{
                let result = try JSONDecoder().decode(Photo.self,from:data)
                completionHandler(result)
                
            }catch{
                completionHandler(nil)
            }
        }.resume()
    }
}


extension URL{
    static let base = "https://api.unsplash.com/"
}

enum Endpoint{
    case search
    
    var requestURL: String{
        switch self {
        case .search:
            return URL.base + "search/photos?query="
        }
    }
}


