//
//  MediaModel.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/13.
//

import Foundation

struct Media{
    var release_date: String
    var vote_average: Float
    var title: String
    var overview: String
    var id: Int
    var poster_path: String
    var backdrop_path: String
    var backdropImageURL: String{
        return  "https://image.tmdb.org/t/p/w500" + backdrop_path
    }
}
