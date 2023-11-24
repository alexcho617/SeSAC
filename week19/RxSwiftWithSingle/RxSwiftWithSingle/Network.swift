//
//  APIManager.swift
//  RxSwiftWithSingle
//
//  Created by jack on 2023/11/24.
//

import UIKit
import RxSwift
import Alamofire

enum JackError {
    case jackError
}

final class Network {
    
//    static let baseUrl = "https://v2.jokeapi.dev/joke/Programming?type=single"
    static let baseUrl = "https://v2.jokeapi.dev/joke/Programming?type=twopart"
    
    static func fetchJoke() -> Single<Result<Joke, Error>> {
        return Single.create { single -> Disposable in
            AF.request(URL(string: baseUrl)!)
                .validate()
                .responseDecodable(of: Joke.self) { response in
                    String(data: response.data!, encoding: .utf8)
                    switch response.result {
                        //에러핸들 2번째 함수 반환 타입을 Result로 바꾸고 response의 두개의 케이스에 전부 single.success 전달
                    case .success(let jokeData):
                        single(.success(.success(jokeData))) //result타입으로 이미 반환
//                        observer.onNext(success)
//                        observer.onCompleted() //해제 시켜줌 동시에 하는게 귀찮아서 하나로 하는게 싱글임
                    case .failure(let jackError):
//                        observer.onError(failure)
                        single(.success(.failure(jackError)))
                    }
                }
            return Disposables.create()
        }
        .debug()
    }
    
 
}
