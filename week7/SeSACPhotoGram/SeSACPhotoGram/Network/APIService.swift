//
//  APIService.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/30.
//

import Foundation

class APIService{
    static let shared = APIService()
    func callRequest(){
    //"https://www.apple.com/105/media/us/apple-events/2023/ad6b79de-2819-4715-be4e-c9f1488ab703/anim/large_2x.mp4" 7메가 바이트
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg") //1.5메가바이트
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(data)
            let value = String(data: data!, encoding: .utf8)
            print(value)
//            print(response)
            print(error)
        }.resume() //이게 있어야 시작
    }
    private init(){}
}
