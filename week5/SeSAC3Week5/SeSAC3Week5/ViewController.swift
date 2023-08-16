//
//  ViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var syncButton: UIButton!
    @IBOutlet var asyncButton: UIButton!
    @IBOutlet var groupButton: UIButton!
     
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    @IBOutlet var fourthImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        syncButton.addTarget(self, action: #selector(syncButtonClicked), for: .touchUpInside)
        asyncButton.addTarget(self, action: #selector(asyncButtonClicked), for: .touchUpInside)
    }
        
    @objc func syncButtonClicked() {
        
        print("sync start")
        downloadImage(imageView: firstImageView, value: "first")
        downloadImage(imageView: secondImageView, value: "second")
        downloadImage(imageView: thirdImageView, value: "third")
        downloadImage(imageView: fourthImageView, value: "fourth")
        print("sync end") //synchronous serial
        
    }
    
    @objc func asyncButtonClicked(){
        print("Async start")
        asyncDownloadImage(imageView: firstImageView, value: "first"){ isDone in
            print(#function,"JobState:",isDone)
            
        }
//        asyncDownloadImage(imageView: secondImageView, value: "second")
//        asyncDownloadImage(imageView: thirdImageView, value: "third")
//        asyncDownloadImage(imageView: fourthImageView, value: "fourth")
        print("Async end")
    }
    
    //글로벌 Concurrnet 큐에 작업을 동시로 보냄
    //언제끝날지는 모름
    //UI는 메인 시리얼 큐에서 처리
    func asyncDownloadImage(imageView: UIImageView, value: String, completionHandler: @escaping (Bool) -> ()) {
        var isDone = false
        DispatchQueue.global().async {
            print("===1===\(value)===", Thread.isMainThread)
            //throws try catch 한묶음
            let data = try! Data(contentsOf: Nasa.photo)
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data) //UI는  main queue 에서만 가능
                print("===2===\(value)===",Thread.isMainThread)
                isDone = true
                completionHandler(isDone)
            }
        }
    }
    func downloadImage(imageView: UIImageView, value: String) {

        print("===1===\(value)===")
        let data = try! Data(contentsOf: Nasa.photo)
        imageView.image = UIImage(data: data)
        print("===2===\(value)===")

    }
    
     
}

