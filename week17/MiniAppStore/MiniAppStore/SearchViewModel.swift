//
//  SearchViewModel.swift
//  MiniAppStore
//
//  Created by Alex Cho on 2023/11/07.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ViewModel{

    var disposeBag = DisposeBag()
    
    struct Input{
        let searchButtonClicked: ControlEvent<Void>
        let query: ControlProperty<String>
    }

    struct Output{
        let items: PublishSubject<[AppInfo]>
    }

    func transform(input: Input) -> Output {
        let appInfo = PublishSubject<[AppInfo]>()
        
        input.searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.query) {$1}
            .distinctUntilChanged()
            .flatMap { query in
                APIManager.fetchData(query: query)
            }
            .subscribe(with: self) { owner, appstoreModel in
                appInfo.onNext(appstoreModel.results)
            }.disposed(by: disposeBag)
        
        return Output(items: appInfo)
    }
}
