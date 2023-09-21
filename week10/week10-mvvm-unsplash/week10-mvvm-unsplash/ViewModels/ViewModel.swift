//
//  ViewModel.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/20.
//

import Foundation
import Combine
final class ViewModel{
    
    //publisher
    @Published var urlString: String = ""{
        didSet{
            print("ViewModel-urlString-didSet: \(urlString)")
        }
    }
    
    
    func request(){
        Network.shared.requestConvertible(type: PhotoResult.self, api: .random) { response in
            switch response {
            case .success(let success):
                self.urlString = success.urls.thumb
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
}
