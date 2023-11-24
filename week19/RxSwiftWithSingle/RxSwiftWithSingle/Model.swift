//
//  Model.swift
//  RxSwiftWithSingle
//
//  Created by jack on 2023/11/24.
//

import Foundation

struct Joke: Codable {
    let error: Bool
    let category, type, joke: String
    let id: Int
    let safe: Bool
    let lang: String
}
