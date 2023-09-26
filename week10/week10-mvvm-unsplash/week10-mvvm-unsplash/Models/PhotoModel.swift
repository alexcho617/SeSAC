//
//  PhotoModel.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/21.
//

import Foundation

struct Photo: Decodable, Hashable{
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable, Hashable{
    let id: String
    let created_at: String
    let urls: PhotoURL
    let width: CGFloat //셀의 넓이와 높이를 계산할때 써야함
    let height: CGFloat
}

struct PhotoURL: Decodable, Hashable{
    let full: String
    let thumb: String
}

