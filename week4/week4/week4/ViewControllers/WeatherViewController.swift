//
//  WeatherViewController.swift
//  week4
//
//  Created by Alex Cho on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
class WeatherViewController: UIViewController {

    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
        
    }
    
    func callRequest(){
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&units=metric&appid=\(APIKey.weatherKey)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let temp = json["main"]["temp"].doubleValue
                let id = json["weather"][0]["id"].intValue
                let humidity = json["main"]["humidity"].doubleValue
                print(temp,id)
                
                switch id {
                case 800: self.weatherLabel.text = "맑음"
                case 801...899: self.weatherLabel.text = "구르미 구르미"
                default:
                    print("나머지는 생략")
                }
                self.tempLabel.text = "\(temp)도"
                self.humidityLabel.text = "\(humidity)%"
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
