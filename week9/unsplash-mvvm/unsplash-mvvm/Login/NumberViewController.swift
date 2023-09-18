//
//  NumberViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/18.
//

import UIKit

class NumberViewController: UIViewController {
    let vm = NumberViewModel()
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        
        bindData()
        super.viewDidLoad()
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)

    }
    
    func bindData(){
        vm.number.bind { num in
            self.numberTextField.text = num
        }
        vm.result.bind { val in
            self.resultLabel.text = val
        }
    }
    
    @objc func numberTextFieldChanged(){
        vm.number.value = numberTextField.text
        vm.convertNumber()
                
    }

}
