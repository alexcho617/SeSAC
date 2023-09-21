//
//  BeerNetwork.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/19.
//

import Foundation
import Alamofire

class BeerNetwork {
    static let shared = BeerNetwork()
    private init() {}
    
    func request<T: Decodable>(type: T.Type, api: BeerRouter, completion: @escaping (Result<T, BeerError>)-> Void){
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result{
            case .success(let data): completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode
                guard let error = BeerError(rawValue: statusCode ?? 500) else {return}
                completion(.failure(error))
            }
        }
        
    }}
