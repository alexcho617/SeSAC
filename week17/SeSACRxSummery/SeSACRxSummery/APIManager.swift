//
//  APIManager.swift
//  SeSACRxSummery
//
//  Created by Alex Cho on 2023/11/09.
//

import Foundation
import Moya

final class APIManager{
    static let shared = APIManager()
    private init(){}
    
    let provider = MoyaProvider<SeSACAPI>()
    func signUp(){
        //completion이 싫으면 rxmoya
        let model = Join(email: "alex2@sesac.com", password: "alexpw", nick: "alex")
        provider.request(SeSACAPI.signUp(model: model)) { result in
            switch result{
            case .success(let value):
                print("Success", value.statusCode, value.data)
                
                let decodedValue = try! JSONDecoder().decode(JoinnResponse.self, from: value.data)
                print("Decoded",decodedValue)
            case .failure(let error):
                print("Error",error)
            }
        }
    }
}
