//
//  BasicAPIManager.swift
//  SeSACRxThreads
//
//  Created by Alex Cho on 2023/11/06.
//

import Foundation
import RxSwift

enum APIError: Error{
    case invalidURL
    case serverError
    case statusError
}
class BasicAPIManager{
    
    //Observable.create 활용
    static func fetchData() -> Observable<SearchAppModel>{
        return Observable<SearchAppModel>.create { value in
            let urlString = "https://itunes.apple.com/search?term=todo&country=KR&media=software&lang=ko_KR&limit=10"
            guard let url = URL(string: urlString) else {
                value.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
//            원래는 이런게 있다
//            URLSession.shared.rx.data(request: <#T##URLRequest#>)
            //closure 내에는 void return
            URLSession.shared.dataTask(with: url) { data, response, error in
                print("URLSession Success")
                if let _ = error {
                    value.onError(APIError.serverError)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    value.onError(APIError.statusError)
                    return
                }
                
                
                if let data = data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data){
                    value.onNext(appData)
                }
                
            }.resume()
            
            return Disposables.create()
        }
    }
    
}
