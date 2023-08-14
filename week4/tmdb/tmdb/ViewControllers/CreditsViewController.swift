//
//  CreditsViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import UIKit

//TODO: 줄거리 부분 줄었다 늘었다 구현: TableView Cell /automaticDimension, layout, label.numberOfLines = 0 혹은 n으로 변경. var isExpanded: Bool 같은 변수로 토글하면서 관리

//TODO: Credits Cast가 엄청 많던데 주연, 조연 순으로 주요 배우들만 정렬 어떻게 하나?
class CreditsViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    var mediaId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mediaId{
            titleLabel.text = "Credits of " + String(mediaId)

            print("calling credits")
            TmdbAPIManager.shared.callCreditsRequest(of: mediaId){json in
//                print(json)
                self.textView.text = json["cast"].arrayValue[0].description + json["cast"].arrayValue[1].description + json["cast"].arrayValue[2].description
            }
        }
        
    }
    func configureView(){
    }
}
