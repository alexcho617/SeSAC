//
//  AlexObs.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/13.
//

import Foundation

class CustomObservable<T>{
   
    
    private var listener: ((T) -> Void)?
    
    var value: T{
        didSet{
            listener?(value)
        }
    }
    init(_ value: T) {
        self.value = value
    }
    
    func bind(sample: @escaping (T) -> Void){
        sample(value) //최초 실행
        listener = sample //이후 전달
    }
    
    
}
