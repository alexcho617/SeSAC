//
//  CastModel.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/13.
//

import Foundation

struct Credits{
    var id: Int
    var cast: [Cast]
}

struct Cast{
    var id: Int
    var name: String
    var character: String
}
