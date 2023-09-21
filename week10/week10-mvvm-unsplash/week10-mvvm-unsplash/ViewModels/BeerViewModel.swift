//
//  BeerViewModel.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/21.
//

import Foundation
import Combine

class BeerViewModel{
    
    @Published var beer: Beer = []
    
    func request(){
        BeerNetwork.shared.request(type: Beer.self, api: .random) { response in
            switch response {
            case .success(let success):
                self.beer = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
}


