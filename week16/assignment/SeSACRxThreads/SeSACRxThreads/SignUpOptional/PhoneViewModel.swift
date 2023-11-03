//
//  PhoneViewModel.swift
//  SeSACRxThreads_Asgnmt
//
//  Created by Alex Cho on 2023/11/02.
//

import Foundation
import RxSwift
import UIKit

class PhoneViewModel{
    let disposeBag = DisposeBag()
    let phoneNumber = BehaviorSubject(value: "010")
    let buttonEnabled = BehaviorSubject(value: false)
    
    
    init() {
        //number -> bool <->button enabled
        phoneNumber.map {$0.count == 13}
            .subscribe(with: self) { owner, value in
                owner.buttonEnabled.onNext(value)
            }
            .disposed(by: disposeBag)
        
        
    }
    
}
