//
//  ViewController.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/19.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.shared.request(type: PhotoResult.self, api: .detail(id: "TkWustNCN5A")) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure)
            }
        }
//        Network.shared.request(type: PhotoResult.self, api: .random) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//        Network.shared.request(type: Photo.self, api: .search(query: "sky")) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
    
        
        //Result<> 쓰지 않았기 때문에 Optional check 해야함
//        NetworkBasic.shared.random { photo, error in
//            guard let photo = photo else {return} //early exit 해버리면 에러는?
//            guard let error = error else {return} //error not nil but exited
//        }
        
        //Result를 썼기 때문에 response라는 하나의 값만 들어옴
//        NetworkBasic.shared.detailPhoto(id: "") { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                dump(failure)
//            }
//        }
    }
    
 

}

struct Photo: Decodable{
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable{
    let id: String
    let created_at: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable{
    let full: String
    let thumb: String
}
