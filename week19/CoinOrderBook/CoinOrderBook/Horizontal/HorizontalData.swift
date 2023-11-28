//
//  HorizontalData.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/27/23.
//

import Foundation
 
struct HorizontalData: Identifiable{
    let id = UUID()
    let data: String
    let point = Int.random(in: 1...5000)
}
