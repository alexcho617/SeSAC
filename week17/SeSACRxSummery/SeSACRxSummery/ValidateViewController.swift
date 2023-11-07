//
//  ValidateViewController.swift
//  SeSACRxSummery
//
//  Created by Alex Cho on 2023/11/07.
//

import UIKit
import RxSwift
import RxCocoa

class ValidateViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var validLabel: UILabel!
    
    @IBOutlet weak var validButton: UIButton!
    let vm = ValidateViewModel()
    func bind(){
        
        let input = ValidateViewModel.Input(text: textField.rx.text, tap: validButton.rx.tap)
        
        let output = vm.transform(input: input)
       
        output.text
            .drive(validLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.validation
            .bind(to: validButton.rx.isEnabled, validLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.validation
            .bind(with: self) { owner, value in
            let color: UIColor = value ? .systemPink : .lightGray
            owner.validButton.backgroundColor = color
        }.disposed(by: disposeBag)
        
        output.tap
            .bind(with: self) { owner, _ in
                print("Tapped")
            }.disposed(by: disposeBag)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()

    }

}
