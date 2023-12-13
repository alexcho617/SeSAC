//
//  NetworkManager.swift
//  SeSACTesting
//
//  Created by Alex Cho on 12/13/23.
//

import Foundation
import Alamofire

protocol NetworkProvider{
    func fetchLotto(completionHandler: @escaping (LottoResponse) -> Void)
}

final class NetworkManager: NetworkProvider{
    //인터넷 연결과 같은 외부환경에 의해 테스트가 의존된다면 안됨.
    //테스트는 일관된 결과를 도춣해야함. 따라서 MockData로 네트워크 통신을하지 않고 테스트를 진행하는것이 적합함.
    static let shared = NetworkManager()
    private init() {}
    
    func fetchLotto(completionHandler: @escaping (LottoResponse) -> Void) { //실제 네트워크 통신
        //alamofire json statuscode error network connection
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1000"

        AF.request(url).responseDecodable(of: LottoResponse.self) { response in
            switch response.result{
            case .success(let lottoResponse):
                print(lottoResponse)
                completionHandler(lottoResponse)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

struct LottoResponse: Codable{
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}
