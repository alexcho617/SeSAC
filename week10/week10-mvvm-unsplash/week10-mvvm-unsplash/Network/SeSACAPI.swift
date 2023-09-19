//
//  SeSACAPI.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/19.
//

import Foundation
import Alamofire

enum SeSACAPI{
    private static let key = "sbHxAxoUWQQasbaPZVJU2ZJ7bW2yXUUdocDy4STY-w8"
    case search(query: String)
    case detail(id: String) //연관값 associated value
    case random
    
    //추후에 버전이 다를 수도 있음: 환경에 따라 여러개 가능
    private var baseURL: String{
        switch self {
        case .search:
            return "https://api.unsplash.com/"
        case .detail:
            return "https://api.unsplash.com/"
        case .random:
            return "https://api.unsplash.com/"
        }
    }
    var endpoint: URL{
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .detail(let id):
            return URL(string: baseURL + "photos/\(id)")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        }
    }
    
    var header: HTTPHeaders{
        return ["Authorization": "Client-ID \(SeSACAPI.key)"]
    }
    
    var method: HTTPMethod{
        return .get
    }
    
    var query: [String: String]{
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .detail:
            return ["": ""]
        }
    }
}
