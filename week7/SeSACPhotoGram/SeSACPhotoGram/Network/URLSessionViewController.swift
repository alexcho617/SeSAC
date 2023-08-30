//
//  URLSessionViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/30.
//

import UIKit

class URLSessionViewController: UIViewController{
    var session: URLSession!
    //"https://www.apple.com/105/media/us/apple-events/2023/ad6b79de-2819-4715-be4e-c9f1488ab703/anim/large_2x.mp4" 7메가 바이트
    let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg") //1.5메가바이트
    override func viewDidLoad() {
        super.viewDidLoad()
        //1 설정
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        //2 데이터 테스크
        session.dataTask(with: URLRequest(url: url!)).resume()
    }
    
}

//응답: Delegate
extension URLSessionViewController: URLSessionDataDelegate{
    //최초 응답받은 경우에 호출 (상태코드 처리)
    //여기서 전체 사이즈 알려줌
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
//
//    }
    
    //데이터를 받을 때마다
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA:",data)
    }
    
    //응답이 완료된 이후
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("End")
    }
}
