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
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var bonusLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    let pickerView = UIPickerView()
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
                let date = json["drwNoDate"].stringValue
                let firstPrize = json["firstWinamnt"].stringValue
                self.amountLabel.text = date
                self.bonusLabel.text = firstPrize + "원"
            case .failure(let error):
                print(error)
            }
        }
        label.text = round
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
