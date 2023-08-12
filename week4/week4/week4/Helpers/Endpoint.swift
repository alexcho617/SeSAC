//
//  Endpoint.swift
//  week4
//
//  Created by Alex Cho on 2023/08/11.
//

import Foundation

/// Manage URLS for API comm
enum Endpoint{
    case blog
    case cafe
    case video
    //let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=\(size)&page=\(page)"
    var requestURL: String{
        switch self {
        case .blog: return URL.makeEndPointString("blog?query=")
        case .cafe: return URL.makeEndPointString("cafe?query=")
        case .video: return URL.makeEndPointString("/vclip?query=")
        }
    }
    
}
