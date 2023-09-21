//
//  BeerModel.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/19.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let beer = try? JSONDecoder().decode(Beer.self, from: jsonData)

import Foundation

// MARK: - BeerElement
struct BeerElement: Codable {
    let id: Int
    let name: String
    let imageURL: String
   

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

typealias Beer = [BeerElement]
