//
//  Router.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/20.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible{
    
    private static let key = "sbHxAxoUWQQasbaPZVJU2ZJ7bW2yXUUdocDy4STY-w8"
    
    case search(query: String)
    case detail(id: String) //연관값 associated value
    case random
    
    private var baseURL: URL{
        return URL(string: "https://api.unsplash.com/")!
    }
    
    //다른 파일에서 접근 필요 없어짐
    private var path: String{
        switch self {
        case .search:
            return "search/photos"
        case .detail(let id):
            return "photos/\(id)"
        case .random:
            return "photos/random"
        }
    }
    
    private var header: HTTPHeaders{
        return ["Authorization": "Client-ID \(Router.key)"]
    }
    
    var method: HTTPMethod{
        return .get
    }
    
    private var query: [String: String]{
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .detail:
            return ["": ""]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.headers = header
        request.method = method
        //서버에 따라 JSON방식으로 인코딩해야할 수 있음
//        JSONParameterEncoder
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        return request
    }
    
    
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, completion: @escaping (Result<T, SeSACError>) -> Void){
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result{
            case .success(let data): completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode
                guard let error = SeSACError(rawValue: statusCode ?? 500) else {return}
                completion(.failure(error))
            }
        }
    }
}
