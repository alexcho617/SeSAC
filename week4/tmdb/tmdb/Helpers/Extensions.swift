//
//  URL + Extension.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import Foundation

extension URL{
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static func makeEndPointString(_ endpoint: String) -> String{
        return baseURL + endpoint
    }
}

