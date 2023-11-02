//
//  BirthdayViewModel.swift
//  SeSACRxThreads_Asgnmt
//
//  Created by Alex Cho on 2023/11/03.
//

import Foundation
import RxSwift

class BirthdayViewModel{
    let disposeBag = DisposeBag()
    
    var birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    let year = BehaviorSubject(value: 1994)
    let month = BehaviorSubject(value: 1)
    let day = BehaviorSubject(value: 1)
    let isNotEligible = BehaviorSubject(value: false)
    
    init() {
        birthday.subscribe(with: self) { [self] owner, date in
            let component = Calendar.current.dateComponents([.year,.month,.day], from: date)
            
            owner.year.onNext(component.year!)
            owner.month.onNext(component.month!)
            owner.day.onNext(component.day!)
            
            let interval = DateInterval(start: date, end: .now)
            print(interval.duration)
            let duration = interval.duration
            //17년을 초로 계산 후 입력된 값과 지금의 차이와 비교
            if duration < (3600 * 24 * 365 * 17){
                isNotEligible.onNext(true)
            }else{
                isNotEligible.onNext(false)
            }
            print(isNotEligible)
        }.disposed(by: disposeBag)
        
    }
}
