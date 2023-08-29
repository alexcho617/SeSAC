//
//  Protocols.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/29.
//

import Foundation
protocol PassDataDelegate{
    func receiveDate(date:Date)
}
//1
protocol PassImageDelegate{
    func passImage(image: String)
}
