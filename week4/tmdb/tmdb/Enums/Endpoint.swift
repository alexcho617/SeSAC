//
//  Endpoint.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import Foundation

enum Endpoint{
    case trend
    case credits
    
    var requestURL: String{
        switch self {
        case .trend:
            return URL.makeEndPointString("trending/movie/week?api_key=\(APIKey.tmdbKey)")
        case .credits:
            return URL.makeEndPointString("movie/")
        }
    }
}
