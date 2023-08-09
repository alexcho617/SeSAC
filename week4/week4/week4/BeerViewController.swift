//
//  BeerViewController.swift
//  week4
//
//  Created by Alex Cho on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Beer{
    var name: String
    var description: String
}
class BeerViewController: UIViewController {
    
    @IBOutlet weak var beerImageView: UIImageView!
    
    @IBOutlet weak var beerNameLabel: UILabel!
    
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCall()
        
    }
    
    @IBAction func suggestionClicked(_ sender: UIButton) {
        requestCall()
    }
    
    func requestCall(){
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let imageUrl = json[0]["image_url"].url
                let name = json[0]["name"].stringValue
                let description = json[0]["description"].stringValue
                if let imageUrl{
                    self.beerImageView.load(url: imageUrl)
                }else{
                    self.beerImageView.image = UIImage(systemName: "drink")
                }
                
                self.beerNameLabel.text = name
                self.beerDescriptionLabel.text = description
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
