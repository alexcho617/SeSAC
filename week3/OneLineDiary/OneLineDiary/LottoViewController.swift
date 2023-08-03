//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by Alex Cho on 2023/08/03.
//

import UIKit

class LottoViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var list: [Int] = Array(1...100).reversed()
//    private var list = Array(repeating: "asdf", count: 10)
//    private var list = [
//        "Movie",
//        "Animation",
//        "Drama",
//        "SF",
//        "Family"
//    ]
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    let pickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.tintColor = .clear
        textField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = String(list[row])
        label.text = selected
        textField.text = selected
    }
//
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(list[row])
    }
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
}
