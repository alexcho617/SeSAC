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

enum TimeWindow: String{
    case day = "day"
    case week = "week"
}

enum Genre: Int {
    case Action = 28
    case Adventure = 12
    case Animation = 16
    case Comedy = 35
    case Crime = 80
    case Documentary = 99
    case Drama = 18
    case Family = 10751
    case Fantasy = 14
    case History = 36
    case Horror = 27
    case Music = 10402
    case Mystery = 9648
    case Romance = 10749
    case ScienceFiction = 878
    case TVMovie = 10770
    case Thriller = 53
    case War = 10752
    case Western = 37
    
    static var genreDictionary: [Int: String] = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
}


