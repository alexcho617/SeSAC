//
//  WalletModel.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/22.
//

import SwiftUI

struct CardModel: Hashable{
    let color = Color.random() //Color 는 스유
    let name: String
    let index: Int
}

var cardDataBank = [
    CardModel(name: "Kakao Bank Check Card", index: 0),
    CardModel(name: "Hana Bank Check Card", index: 1),
    CardModel(name: "Hyundai Zero Credit Card", index: 2)
]
