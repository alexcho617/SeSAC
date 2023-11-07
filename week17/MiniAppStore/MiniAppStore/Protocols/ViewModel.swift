//
//  Protocols.swift
//  MiniAppStore
//
//  Created by Alex Cho on 2023/11/07.
//

import Foundation
import RxSwift

protocol ViewModel{
    associatedtype Input
    associatedtype Output
    var disposeBag: DisposeBag {get set}
    func transform(input: Input) -> Output
}
