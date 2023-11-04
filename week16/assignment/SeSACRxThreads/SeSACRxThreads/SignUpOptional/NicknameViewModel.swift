//
//  NicknameViewModel.swift
//  SeSACRxThreads_Asgnmt
//
//  Created by Alex Cho on 2023/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class NicknameViewModel{
    let name = PublishSubject<String>()
    let isValid = BehaviorSubject(value: false)
    let bag = DisposeBag()
    
    init() {
        name
            .map{ 2 < $0.count && $0.count <= 6 }
            .bind(to: isValid)
            .disposed(by: bag)
    }
}
