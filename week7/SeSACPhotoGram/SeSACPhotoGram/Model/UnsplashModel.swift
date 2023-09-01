//
//  UnsplashModel.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/30.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let unsplash = try? JSONDecoder().decode(Unsplash.self, from: jsonData)
import Foundation

// MARK: - Unsplash
struct Unsplash: Codable {
    let total, totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let id, slug: String
    let createdAt, updatedAt, promotedAt: String?
    let width, height: Int
    let color, blurHash: String
    let description: String?
    let altDescription: String
    let urls: Urls
    let likes: Int
    let likedByUser: Bool?

    enum CodingKeys: String, CodingKey {
        case id, slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls, likes, likedByUser
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

///
///퀵타입 안쓰고 만듬
struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
