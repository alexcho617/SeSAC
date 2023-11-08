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
