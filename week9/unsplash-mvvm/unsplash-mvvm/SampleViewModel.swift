//
//  SampleViewModel.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/12.
//

import Foundation

//데이터 가공 역활
class SampleViewModel{
    var list = [User(name: "Alex", age: 21),User(name: "Blex", age: 22),User(name: "Clex", age: 23)]
    
    var numberOfRowsInSection: Int {
        list.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> User{
        return list[indexPath.row]
    }
}
