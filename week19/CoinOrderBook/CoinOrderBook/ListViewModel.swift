//
//  ListViewModel.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/21.
//

import Foundation

//해당 클래스를 관찰할 수 있게 함
class ListViewModel: ObservableObject{
    //Hashabe 하지 않으면 하나로 인지하게 됨
    @Published var market = [Market(market: "aa-aa", korean_name: "aa", english_name: "aaa")]

    func fetchAllMarket(){

//    func fetchAllMarket(completion: @escaping([Market]) -> Void){
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {return}
            
            do{
                let decodedData = try? JSONDecoder().decode([Market].self, from: data)
                DispatchQueue.main.async{
                    self.market = decodedData ?? []
                }
            } catch{
                print(error)
            }

        }.resume()
        
    }
}
