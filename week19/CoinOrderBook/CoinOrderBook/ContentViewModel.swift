//
//  ContentViewModel.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/21.
//

import Foundation

//view는 구조체, vm은 왜 클래스?
class ContentViewModel: ObservableObject{
    
    //@published는 데이터가 바뀔 때마다 뷰가 업데이트 됨.
    //Emit change event
    @Published var banner = Banner()
    
    func fetchBanner(){
        banner = Banner()
    }
    @Published var money: [Market] = []

    func fetchAllMarket(){

//    func fetchAllMarket(completion: @escaping([Market]) -> Void){
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {return}
            
            do{
                let decodedData = try? JSONDecoder().decode([Market].self, from: data)
                DispatchQueue.main.async{
                    self.money = decodedData ?? []
                }
            } catch{
                print(error)
            }

        }.resume()
        
    }
    
}
