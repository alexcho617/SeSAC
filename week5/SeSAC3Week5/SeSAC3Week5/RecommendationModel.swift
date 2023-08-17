//
//  RecommendationModel.swift
//  SeSAC3Week5
//
//  Created by Alex Cho on 2023/08/17.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recommendation = try? JSONDecoder().decode(Recommendation.self, from: jsonData)

import Foundation

// MARK: - Recommendation
struct Recommendation: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title: String
    let originalLanguage: String?
    let originalTitle, overview: String
    let posterPath: String?
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

