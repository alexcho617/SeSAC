//
//  SearchViewModel.swift
//  MiniAppStore
//
//  Created by Alex Cho on 2023/11/07.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel{
    
    var data: [AppInfo] = []
//    var data = ["1","2","3","4","5"]
    lazy var items = BehaviorSubject(value: data)
    var disposeBag = DisposeBag()
    
//    struct Input{
//
//    }
//
//    struct Output{
//
//    }
//
//    func transform(input: Input) -> Output {
//
//        return Output()
//    }
}
