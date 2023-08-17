//
//  VideoSearch.swift
//  week4
//
//  Created by Alex Cho on 2023/08/17.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let videoSearch = try? JSONDecoder().decode(VideoSearch.self, from: jsonData)

import Foundation

// MARK: - VideoSearch
struct VideoSearch: Codable {
    var documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let author: String
    let datetime: String
    let playTime: Int
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author, datetime
        case playTime = "play_time"
        case thumbnail, title, url
    }
}


// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
