//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by Alex Cho on 2023/11/02.
//

import Foundation
import RxSwift
//import RxCocoa //이거까진인정

class BirthdayViewModel{
    
    let disposeBag = DisposeBag()
    let birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    let year = BehaviorSubject(value: 2020)
    let month = BehaviorSubject(value: 12)
    let day = BehaviorSubject(value: 31)
    
    init(){
        birthday
            .subscribe(with: self) { owner, date in
                //extract date components
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                owner.year.onNext(component.year!)
                owner.month.onNext(component.month!)
                owner.day.onNext(component.day!)
                
            }onDisposed: { owner in
                print(owner,"bday", "disposed")
            }
            .disposed(by: disposeBag)
    }
    
}
