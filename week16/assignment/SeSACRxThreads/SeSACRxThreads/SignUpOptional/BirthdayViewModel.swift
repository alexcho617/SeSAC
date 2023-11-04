//
//  BirthdayViewModel.swift
//  SeSACRxThreads_Asgnmt
//
//  Created by Alex Cho on 2023/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class BirthdayViewModel{
    let disposeBag = DisposeBag()
    
    var birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    
    let year = BehaviorRelay(value: 1994)
    let month = BehaviorRelay(value: 1)
    let day = BehaviorRelay(value: 1)
    
    let isEligible = BehaviorSubject(value: false)
    
    init() {
        birthday.subscribe(with: self) { [self] owner, date in
            let component = Calendar.current.dateComponents([.year,.month,.day], from: date)
            
            owner.year.accept(component.year!)
            owner.month.accept(component.month!)
            owner.day.accept(component.day!)
            
            let interval = DateInterval(start: date, end: .now)
            let duration = interval.duration
            //17년을 초로 계산 후 입력된 값과 지금의 차이와 비교
            if duration > (3600 * 24 * 365 * 17){
                isEligible.onNext(true)
            }else{
                isEligible.onNext(false)
            }
            print(try! isEligible.value())
        }.disposed(by: disposeBag)
        
    }
}
