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
            return URL.makeEndPointString("trending/")
        case .credits:
            return URL.makeEndPointString("movie/")
        }
    }
}

enum MediaType: String{
    case all = "all"
    case movie = "movie"
    case tv = "tv"
    case person = "pe4rson"
}

enum TimeWindow: String{
    case day = "day"
    case week = "week"
}

