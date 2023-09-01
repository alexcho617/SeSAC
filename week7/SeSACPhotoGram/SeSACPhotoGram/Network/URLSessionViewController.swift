//
//  URLSessionViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/30.
//

import UIKit

class URLSessionViewController: UIViewController{
    var session: URLSession!
    var totalSize: Double = 0
    var buffer: Data? = Data() { //buffer?.append(data)가 실행되기 위해 초기화를 같이한다.
        didSet{
            let result = Double(buffer?.count ?? 0) / totalSize
            progressLabel.text = "\(Int(result * 100))%"
            print(result, totalSize)
        }
    }
    
    let progressLabel = {
        let view = UILabel()
        view.backgroundColor = .black
        view.textColor = .white
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    //"https://www.apple.com/105/media/us/apple-events/2023/ad6b79de-2819-4715-be4e-c9f1488ab703/anim/large_2x.mp4" 7메가 바이트
    let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg") //1.5메가바이트
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        view.addSubview(progressLabel)
        view.addSubview(imageView)
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        //1 설정
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main) //여기서 타임아웃 설정
        
        //2 데이터 테스크
        session.dataTask(with: URLRequest(url: url!)).resume() //task는 몇개 할 수 있는가? 여러 이미지를 동시에 받으면 어떻게 해야하는가?
    }
    
    //카톡사진: 다운로드 중에 채팅방으로 넘어가면? 취소 버튼? 계속 다운로드?
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //즉각 취소
        session.invalidateAndCancel()
        print("Download canceled")
        
        //기다렸다가 현재꺼 끝나면 정리
        session.finishTasksAndInvalidate()
    }
    
}

//응답: Delegate으로 할 수 있는것들
extension URLSessionViewController: URLSessionDataDelegate{
    //최초 응답받은 경우에 호출 (상태코드 처리)
    //여기서 전체 사이즈 알려줌
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("RESPONSE", response) //Content Length 에서 알려줌
        
        if let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode){
            totalSize = Double(response.value(forHTTPHeaderField: "Content-Length")!) ?? 0 //없을때 대응도 해야함
            return .allow
        }else{
            return .cancel
        }
    }
    
    //데이터를 받을 때마다
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA:",data)
        buffer?.append(data) //optional chaining 때문에 동작하지 않음. 처음에 버퍼는 nil이기 때문에 체이닝에 의해 append가 실행되지 않음
        imageView.image = UIImage(data: buffer!)
    }
    
    //응답이 완료된 이후
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("End")
        if let error{
            print(error)
        }else{
            guard let buffer = buffer else{return}
            imageView.image = UIImage(data: buffer) //이미 메인 쓰레드로 //1에서 설정했다. delegateQueue: .main


        }
    }
}
