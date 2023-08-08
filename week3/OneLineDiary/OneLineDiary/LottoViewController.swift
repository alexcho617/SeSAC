//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by Alex Cho on 2023/08/03.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var list: [Int] = Array(1...1079).reversed()
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    let pickerView = UIPickerView()
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var prizeLabel: UILabel!
    
    
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.tintColor = .clear
        textField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        let latestRound = "1079"
        callLotteryRequest("1079")
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        list.count
    }
    
    fileprivate func callLotteryRequest(_ round: String) {
        //Alamofire SwiftyJSON Practice
        let url: String = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=" + round
        
        AF.request(url, method: .get).validate(statusCode: 200...300).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value) //SwiftyJSON
                print(json)
                let date = json["drwNoDate"].stringValue
                let firstPrize = json["firstWinamnt"].stringValue
                
                var numbers:[Int] = []
                numbers.append(json["drwtNo1"].intValue)
                numbers.append(json["drwtNo2"].intValue)
                numbers.append(json["drwtNo3"].intValue)
                numbers.append(json["drwtNo4"].intValue)
                numbers.append(json["drwtNo5"].intValue)
                numbers.append(json["drwtNo6"].intValue)
                
                let bonus = json["bnusNo"].intValue
                
                self.dateLabel.text = date
                self.prizeLabel.text = "1등 상금:" + firstPrize + "원"
                self.numberLabel.text = "당첨번호:\(numbers) \n 보너스:\(bonus.description)"
                
            case .failure(let error):
                print(error)
            }
        }
        label.text = round + "회차"
        textField.text = round
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = String(list[row])
        callLotteryRequest(selected)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(list[row])
    }
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
}
