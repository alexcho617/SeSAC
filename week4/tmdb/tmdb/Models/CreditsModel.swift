//
//  CastModel.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/13.
//

import Foundation
//
//struct Credits{
//    var id: Int
//    var cast: [Cast]
//}
//
//struct Cast{
//    var id: Int
//    var name: String
//    var character: String
//}

import Foundation

// MARK: - Credits
struct Credits: Codable {
    let id: Int
    let cast, crew: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, job
    }
}

