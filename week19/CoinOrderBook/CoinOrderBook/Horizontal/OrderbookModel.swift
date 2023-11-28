//
//  OrderbookModel.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/28/23.
//

import Foundation
//"market": "KRW-BTC",
//"timestamp": 1701136210841,
//"total_ask_size": 1.18013949,
//"total_bid_size": 11.49553296,
//"orderbook_units": [15 items]
struct OrderBookModel: Decodable {
    let market: String
    let timestamp: Int
    let total_ask_size,total_bid_size: Double
    let orderbook_units: [OrderBookUnit]
}

//"ask_price": 50050000,
//"bid_price": 50030000,
//"ask_size": 0.0236525,
//"bid_size": 1.01780454
struct OrderBookUnit: Decodable {
    let ask_price, bid_price: Double
    let ask_size, bid_size: Double
}

//Model for view
struct OrderbookItem: Hashable, Identifiable{
    let id = UUID()
    let price: Double
    let size: Double
}
