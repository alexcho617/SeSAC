//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by Alex Cho on 2023/11/02.
//

import Foundation
import RxSwift
import RxCocoa //이거까진인정

class BirthdayViewModel{
    
    let disposeBag = DisposeBag()
    
    let birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    
    let year = BehaviorRelay(value: 2020)
    let month = BehaviorRelay(value: 12)
    let day = BehaviorRelay(value: 31)
    
    init(){
        birthday
            .subscribe(with: self) { owner, date in
                //extract date components
                //여기도 사실 실패할 가능성이 없고 레이블에 그대로 전달해주는 상태이기 때문에 서브젝트 사용 할 필요가 없음. 솔직히 그냥 서브젝트 써도 되는데 학습적으로의 차이를 아는게 중요하다
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                owner.year.accept(component.year!)
                owner.month.accept(component.month!)
                owner.day.accept(component.day!)
                
            }onDisposed: { owner in
                print(owner,"bday", "disposed")
            }
            .disposed(by: disposeBag)
    }
    
}
