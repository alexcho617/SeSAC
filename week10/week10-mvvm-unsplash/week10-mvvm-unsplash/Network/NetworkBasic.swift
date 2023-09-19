//
//  NetworkBasic.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/19.
//

import Foundation
import Alamofire
enum SeSACError: Int, Error, LocalizedError {
    case missingParameter = 400
    case unauthorized = 401
    case permissionDenied = 403
    case invalidServer = 500
    
    var errorDescription: String {
        switch self {
        case .missingParameter:
            return "검색어를 입력해주세요"
        case .unauthorized:
            return "인증 정보가 없습니다"
        case .permissionDenied:
            return "권한이 없습니다"
        case .invalidServer:
            return "서버 점검 중입니다"
        }
    }
}
class NetworkBasic{
    
    static let shared = NetworkBasic()
    private init(){}
    
    //escaping closure parameter들이 많기 때문에 경우의 수가 많아질수 있다. 2^n 따라서 result타입을 만듬
    func request(api: SeSACAPI, completion: @escaping (Result<Photo, SeSACError>) -> Void){
       
        //원래 query string으로 보내야 하는데 parameter(바디)에 보내고있다(default으로 바디로 보냄) -> encoding옵션으로 대응
        AF.request(api.endpoint, method: api.method,parameters: api.query ,encoding: URLEncoding(destination: .queryString), headers: api.header).responseDecodable(of: Photo.self) { response in
            switch response.result{
            //각 케이스에 따라 성공이나 실패 둘중 하나의 값만 전달한다
            case .success(let data): completion(.success(data))
            case .failure(_): //wildcard 식별자로 alamofire에서 던져주는 에러를 사용하지 않음
                let statusCode = response.response?.statusCode
                guard let error = SeSACError(rawValue: statusCode ?? 500) else {return}
                completion(.failure(error))
            }
        }
    }
    
    //protocol type
    func random(api: SeSACAPI, completion: @escaping(Result<PhotoResult, SeSACError>) -> Void){
        AF.request(api.endpoint, method: api.method, headers: api.header).responseDecodable(of: PhotoResult.self) { response in
            switch response.result{
            case .success(let data):
                completion(.success(data))
            case .failure(_): //wildcard 식별자로 alamofire에서 던져주는 에러를 사용하지 않음
                let statusCode = response.response?.statusCode
                guard let error = SeSACError(rawValue: statusCode ?? 500) else {return}
                completion(.failure(error))
            }
        }
    }
    
    func detailPhoto(api: SeSACAPI, id: String, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void){
        AF.request(api.endpoint, method: api.method, headers: api.header).responseDecodable(of: PhotoResult.self) { response in
            switch response.result{
            case .success(let data): completion(.success(data))
            case .failure(_): //wildcard 식별자로 alamofire에서 던져주는 에러를 사용하지 않음
                let statusCode = response.response?.statusCode
                guard let error = SeSACError(rawValue: statusCode ?? 500) else {return}
                completion(.failure(error))            }
        }
    }
}
