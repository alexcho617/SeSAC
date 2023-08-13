//
//  CreditsViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import UIKit

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
