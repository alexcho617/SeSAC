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
    let point = Int.random(in: 100...3000)
}

let horizontalDummy = [
    HorizontalData(data: "Bitcoin"),
    HorizontalData(data: "Dogecoin"),
    HorizontalData(data: "Ripple"),
    HorizontalData(data: "Tezos")
]

func largest() -> Int{
    let data = horizontalDummy.sorted { $0.point > $1.point}
    return data.first?.point ?? 0
}
