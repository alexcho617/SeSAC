//
//  HorizontalViewModel.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/27/23.
//

import SwiftUI

class HorizontalViewModel: ObservableObject {
    @Published var value = 0.0
    @Published var dummy: [HorizontalData] = []
    
    @Published var askOrderbook: [OrderbookItem] = []
    @Published var bidOrderbook: [OrderbookItem] = []
    let market: Market
    
    init(market: Market) {
        self.market = market
    }
    
    let unit = 1
    func timer(){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(unit), repeats: true) { timer in
            self.value += Double(self.unit)
            self.fetchOrderbook()
        }
    }
    

    
    //실시간이기 때문에 소켓 통신이 적합함
    func fetchOrderbook(){
        let url = URL(string: "https://api.upbit.com/v1/orderbook?markets=\(self.market.market)")!
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {return}
            
            do{
                let decodedData = try? JSONDecoder().decode([OrderBookModel].self, from: data)
                guard let result = decodedData?.first?.orderbook_units else {
                    print("Decoding Failed")
                    return
                }
                
                let askItems = result.map { unit in
                    OrderbookItem(price: unit.ask_price, size: unit.ask_size)
                }.sorted(by: {$0.price > $1.price})
                
                let bidItems = result.map { unit in
                    OrderbookItem(price: unit.ask_price, size: unit.ask_size)
                }.sorted(by: {$0.price > $1.price})
                DispatchQueue.main.async{
                    //market 정보가 1개라 배열에 첫번째만 가져오면 됨. [0] 대신에 .first를 쓰는 이유는 런타임 오류 때문
                    self.askOrderbook = askItems
                    self.bidOrderbook = bidItems
                                        
                }
                
            } catch{
                print(error)
            }

        }.resume()
        
    }
    
    func largestAskSize() -> Double{
        return askOrderbook.sorted { $0.size > $1.size }.first?.size ?? 0.0
    }
    
    func largestBidSize() -> Double{
        return bidOrderbook.sorted { $0.size > $1.size }.first?.size ?? 0.0
    }
}
//    func fetchDummyData(){
//        dummy = [
//            HorizontalData(data: "Aitcoin"),
//            HorizontalData(data: "Bitcoin"),
//            HorizontalData(data: "Citcoin"),
//            HorizontalData(data: "Ditcoin"),
//            HorizontalData(data: "Gitcoin"),
//            HorizontalData(data: "Dogecoin"),
//            HorizontalData(data: "Ripple"),
//            HorizontalData(data: "Tezos")
//        ]
//    }
    
//    func largest() -> CGFloat{
//        let data = dummy.sorted { $0.point > $1.point}
//        return CGFloat(data.first?.point ?? 0)
//    }
//
