//
//  ValidateViewModel.swift
//  SeSACRxSummery
//
//  Created by Alex Cho on 2023/11/07.
//

import Foundation
import RxSwift
import RxCocoa

class ValidateViewModel{
    
    //데이터가 많아져 복잡해질 경우 한번 더 추상화
    
    //이렇게 하면 View가 없어도 input만 vm에 인젝트 해주면 비즈니스 로직을 다 테스트 할 수 있음
    struct Input{
        let text: ControlProperty<String?> //textField.rx.text
        let tap: ControlEvent<Void> // nameButton.rx.tap
    }
    
    struct Output{
        let tap: ControlEvent<Void> // nameButton.rx.tap
        let text: Driver<String>
        let validation: Observable<Bool>
    }
    
    func transform(input: Input) -> Output{
        let validText = BehaviorRelay(value: "닉네임은 8글자 이상").asDriver()

        let validation = input.text.orEmpty
            .map{ $0.count >= 8}
        
        return Output(
            tap: input.tap,
            text: validText,
            validation: validation
        )
    }
}
