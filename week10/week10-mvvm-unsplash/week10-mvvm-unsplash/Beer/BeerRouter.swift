//
//  BeerRouter.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/21.
//

import Foundation
import Alamofire

enum BeerError: Int, Error, LocalizedError {
    case missingParameter = 400
    case unauthorized = 401
    case permissionDenied = 403
    case invalidServer = 500
    
    var errorDescription: String {
        switch self {
        case .missingParameter:
            return "검색어를 입력해주세요"
        case .unauthorized:
            return "인증 정보가 없습니다"
        case .permissionDenied:
            return "권한이 없습니다"
        case .invalidServer:
            return "서버 점검 중입니다"
        }
    }
}
enum BeerRouter: URLRequestConvertible{
    
    case search(query: String)
    case random
    case single(id: String)
    
    private var baseURL: URL{
        return URL(string: "https://api.punkapi.com/v2/")!
    }
    
    private var path: String{
        switch self {
        case .search:
            return "beers"
        case .random:
            return "beers/random"
        case .single(let id):
            return "beers/\(id)"
        }
    }
    
    private var method: HTTPMethod{
        return .get
    }
    
    private var query: [String?: String?]{
        switch self {
        case .search(let query):
            return ["beer_name": query]
        case .random, .single:
            return [nil: nil]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appending(path: path)
        var request = URLRequest(url: url)
        request.method = method
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        return request
    }
    

}
