//
//  UpbitAPI.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/21.
//

import Foundation

struct Market: Decodable, Hashable{ //구조체의 값이 다 다르기 떄문에 고유성이 보장됨 따라서 identifiable 필요 없음
    let market: String
    let korean_name: String
    let english_name: String
    
//    enum CodingKeys: String, CodingKey {
//        case market
//        case kr = "korean_name"
//        case eng = "english_name"
//    }
}
struct MarketResponse: Decodable{
    let markets: [Market]
}
struct UpbitAPI{
    private init(){}
    static func fetchAllMarket(completion: @escaping([Market]) -> Void){
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {return}
            
            do{
                let decodedData = try? JSONDecoder().decode([Market].self, from: data)
//                print(decodedData)
                DispatchQueue.main.async{
                    completion(decodedData ?? [])
                }
                
            } catch{
                print(error)
            }

        }.resume()
        
    }
}
