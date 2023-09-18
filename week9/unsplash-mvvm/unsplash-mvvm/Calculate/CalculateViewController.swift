//
//  CalculateViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/13.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    var vm = CalculateViewModel()
    
    //MARK: View(ViewController) -> ViewModel
    @objc func firstTextFieldChanged(){
        vm.firstNumber.value = firstTextField.text
        vm.calculate()
        vm.presentNumberFormat()
    }
    @objc func secondTextFieldChanged(){
        vm.secondNumber.value = secondTextField.text
        vm.calculate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTextField.addTarget(self, action: #selector(firstTextFieldChanged), for: .editingChanged)
        
        secondTextField.addTarget(self, action: #selector(secondTextFieldChanged), for: .editingChanged)
        
        //MARK: ViewModel -> View (ViewController)
        vm.firstNumber.bind { number in
            self.firstTextField.text = number
        }
        
        vm.secondNumber.bind { number in
            self.secondTextField.text = number
        }
        
        vm.result.bind { text in
            self.resultLabel.text = text
        }
        
        vm.tempText.bind { text in
            self.tempLabel.text = text
        }
    }
   
}














//
//let obs = CustomObservable("Alex")
//obs.value = "aaa"
//obs.value = "bbb"
//
////여기서 함수 내용이 closure에 담겨서 sample로 전달 되고 sample에서 listener로 전달 된다
//obs.bind { value in
//    self.resultLabel.text = value
//    self.view.backgroundColor = [UIColor.systemMint,UIColor.red,UIColor.yellow, UIColor.blue,UIColor.orange, UIColor.gray, UIColor.green].randomElement()!
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//    obs.value = "ccc"
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//    obs.value = "ddd"
//}
