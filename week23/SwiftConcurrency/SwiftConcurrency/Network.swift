//
//  Network.swift
//  SwiftConcurrency
//
//  Created by Alex Cho on 12/19/23.
//

import Foundation
import UIKit

enum AlexError: Error{
    case invalidResponse
    case unknown
    case invalidImage
}

final class Network{
    static let shared = Network()
    private init() {}
    let stone = "8YaP48tVfngbURGldWk1I5odsBK.jpg"
    let chamber = "sfs4U6XpiKFngbbSzrpZbkM1ySI.jpg"
    let prisoner = "anwNl1xbzXoj5Ax1nVw3WoDzHlw.jpg"
    
    func fethThumbnil(completion: @escaping (UIImage) -> Void) {
        let url = "https://www.themoviedb.org/t/p/w1280/8YaP48tVfngbURGldWk1I5odsBK.jpg"
        
        DispatchQueue.global().async{
            if let data = try? Data(contentsOf: URL(string: url)!){
                if let image = UIImage(data: data){ //Globa queue 에서 UI변경하려는 경고
                    DispatchQueue.main.async{
                        completion(image)
                    }
                    
                }
            }
        }
    }
    
    /*
     1. completion handler 빼먹어도 오류 안남
     2. 둘 다 nil을 넣어도 문법적으로 오류가 안남, 둘 다 넣어도 오류가 안남 -> Result<T,E>으로 해결 가능
     
     */
    func fetchWithURLSession(completion: @escaping (Result<UIImage,AlexError>) -> Void){
        let url = URL(string: "https://www.themoviedb.org/t/p/w1280/8YaP48tVfngbURGldWk1I5odsBK.jpg")!
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 3)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            //data exists
            guard let data else {
                //                completion(nil, .unknown)
                completion(.failure(.unknown))
                return
            }
            
            //there is no error
            guard error == nil else {
                //                completion(nil, .unknown)
                completion(.failure(.unknown))
                return
            }
            
            //statusCode is ok
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                //                completion(nil, .invalidResponse)
                completion(.failure(.invalidResponse))
                return
            }
            
            //uiimage created
            guard let image = UIImage(data: data) else{
                //                completion(nil, .invalidImage)
                
                completion(.failure(.invalidImage))
                return
            }
            completion(.success(image))
            
            
        }.resume()
    }
    /*
     sfs4U6XpiKFngbbSzrpZbkM1ySI.jpg
     anwNl1xbzXoj5Ax1nVw3WoDzHlw.jpg
     8YaP48tVfngbURGldWk1I5odsBK.jpg
     */
    func fetchThumbnailAsyncAwait(path: String) async throws -> UIImage {
        let url = URL(string: "https://www.themoviedb.org/t/p/w1280/\(path)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 3)
        
        //await: 비동기 처리
        let (data, response) =  try await URLSession.shared.data(for: request)
        
        //예외처리
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw AlexError.invalidResponse}
        guard let image = UIImage(data: data) else {throw AlexError.invalidImage}
        
        print(url.description)
        //전달
        return image
    }
    
    //비동기 wrapper: 좋으나 콜 갯수 유한
    func fetchThumbnailAsyncLet() async throws -> [UIImage] {
        print(#function)
        
        //async let에서 try await가 없기 때문에 각각 독립적으로 수행 후 3개가 다 끝났을때 이미지 배열 리턴 돔
        async let image = Network.shared.fetchThumbnailAsyncAwait(path: stone)
        async let image2 = Network.shared.fetchThumbnailAsyncAwait(path: chamber)
        async let image3 = Network.shared.fetchThumbnailAsyncAwait(path: prisoner)
        
        return try await [image,image2, image3]
    }
    
    //taskgroup 콜 갯수 동적: dynamic child tasks
    func fetchThumbnailTaskGroup() async throws -> [UIImage]{
        let posters = [stone,chamber,prisoner]
        
        return try await withThrowingTaskGroup(of: UIImage.self) { group in //받고싶은 데이터 타입 명시, 그룹으로 관리
            //GCD Dispatch Group enter and leave 랑 비슷
            for poster in posters {
                group.addTask { //group에 child task 갯수 알려줌
                    try await self.fetchThumbnailAsyncAwait(path:poster)
                }
            }
            var resultImages: [UIImage] = []

            
            for try await item in group{
                resultImages.append(item)
            }
            return resultImages
        }
    }
}
