//
//  ViewModelProtocol.swift
//  SeSACRxSummery
//
//  Created by Alex Cho on 2023/11/08.
//

import Foundation
import RxSwift

protocol ViewModel{
    associatedtype Input
    associatedtype Output
    var disposeBag: DisposeBag { get set }
    func transform(input: Input) -> Output
}


class TestViewModel: ViewModel{
    
    var disposeBag = DisposeBag()
    
    struct Input{
        
    }
    
    struct Output{
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
}

