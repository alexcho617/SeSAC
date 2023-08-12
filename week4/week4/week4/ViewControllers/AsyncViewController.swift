//
//  AsyncViewController.swift
//  week4
//
//  Created by Alex Cho on 2023/08/11.
//

import UIKit

class AsyncViewController: UIViewController {

    @IBOutlet weak var first: UIImageView!
    
    @IBOutlet weak var second: UIImageView!
    
    
    @IBOutlet weak var third: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        first.backgroundColor = .black
        //스토리 보드 기반의 사이즈가 먼저 계산되기 떄문에 스토리보드에서 디자인한 말고 다른 다른 기기에선 원이 나오지 않는다.
        DispatchQueue.main.async { [self] in
            first.layer.cornerRadius = first.frame.width/2
        }
    }
    
    @IBAction func clearButtonClicked(_ sender: UIButton) {
        DispatchQueue.main.async { [self] in
            first.image = nil
            print("Cleared")
        }
    }
    

    @IBAction func buttonClicked(_ sender: UIButton) {
        let url = URL(string: "https://api.nasa.gov/assets/img/general/apod.jpg")!
        //Global(Concurrent) Queue Asynchronous
        //이거 escaping closure로 개선 할 수 있을듯. 받아온 데이터로 뭘 할지는 뷰에서 알아서 할 일.
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                self.first.image = UIImage(data: data)
                print("Got image")
            }
        }
    }
}
