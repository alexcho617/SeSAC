//
//  Example.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/16.
//

import Foundation

func fetchLottoData() {
    let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
    
    AF.request(url, method: .get).validate()
        .responseData { response in
            guard let value = response.value else { return }
            print("responseData:", value)
        }
    
    
    AF.request(url, method: .get).validate()
        .responseString { response in
            guard let value = response.value else { return }
            print("responseString:", value)
        }
    
    AF.request(url, method: .get).validate()
        .response { response in
            guard let value = response.value else { return }
            print("response:", value)
        }
     
    AF.request(url, method: .get).validate()
        .responseDecodable(of: Lotto.self) { response in
            guard let value = response.value else { return }
            print("responseDecodable:", value)
        }

}


func fetchTranslateData(source: String, target: String, text: String) {
    
    print("fetchTranslateData", source, target, text)
    
    let url = "https://openapi.naver.com/v1/papago/n2mt"
    let header: HTTPHeaders = [
        "X-Naver-Client-Id": Key.clientID,
        "X-Naver-Client-Secret": Key.clientSecret
    ]
    let parameters: Parameters = [
        "source": source,
        "target": target,
        "text": text
    ]
    
    AF.request(url, method: .post, parameters: parameters, headers: header)
        .validate(statusCode: 200...500)
        .responseDecodable(of: Translation.self) { response in
            
            guard let value = response.value else { return }
            
        }

}

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

struct Translation: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let service, version: String
    let result: Result
    let type: String

    enum CodingKeys: String, CodingKey {
        case service = "@service"
        case version = "@version"
        case result
        case type = "@type"
    }
}

// MARK: - Result
struct Result: Codable {
    let engineType, tarLangType, translatedText, srcLangType: String
}
