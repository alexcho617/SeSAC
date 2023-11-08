//
//  BoxOfficeViewModel.swift
//  SeSACRxSummery
//
//  Created by Alex Cho on 2023/11/08.
//

import Foundation
import RxSwift
import RxCocoa

class BoxOfficeViewModel: ViewModel{
    var disposeBag = DisposeBag()
    struct Input{
        let searchButtonClicked: ControlEvent<Void> // searchBar.rx.searchButtonClicked
        let query: ControlProperty<String> //searchBar.rx.text.orEmpty
        let recentText: PublishSubject<String> //Observable.zip(tableview.rx.itemselected, tableview.rx.modelselected)
        
    }
    
    struct Output{
        let recentList: BehaviorRelay<[String]> //BehaviorRelay(value: ["4","5","6"])
        let items: PublishSubject<[DailyBoxOfficeList]> //PublishSubject<[DailyBoxOfficeList]>() //서버통신 결과
    }
    
    func transform(input: Input) -> Output{
        
        //temp variables for return
        let boxofficeList = PublishSubject<[DailyBoxOfficeList]>()
        
        var recent = ["4","5","6"]
        let recentList = BehaviorRelay<[String]>(value: recent)
        

        //process
        input.searchButtonClicked //input
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .withLatestFrom(input.query, resultSelector: { $1 }) //input
            .map{ text -> Int in //validation
                guard text.count == 8, let newText = Int(text) else {return 20231106}
                return newText
            }
            .flatMap{ date in
                BoxOfficeNetwork.fetchBoxOfficeData(date: "\(date)")
            }
            .subscribe(with: self) { owner, movie in
                let data = movie.boxOfficeResult.dailyBoxOfficeList
                boxofficeList.onNext(data)
            }.disposed(by: disposeBag)
        
        input.recentText
            .subscribe(with: self) { owner, text in
                recent.append(text)
                recentList.accept(recent)
            }.disposed(by: disposeBag)
        
        return Output(recentList: recentList, items: boxofficeList)
    }
}
