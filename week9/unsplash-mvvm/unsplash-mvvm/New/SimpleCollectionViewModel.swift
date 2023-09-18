//
//  SimpleCollectionViewModel.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/18.
//

import Foundation
class SimpleCollectionViewModel{
    // observable on array of user
    let list: Observable<[User]> = Observable([])
    var list2 = [User(name: "Blex", age: 21),
                User(name: "Blex", age: 21),
                User(name: "Blex", age: 23)
                ]
    func append() {
        list.value = ([User(name: "Alex", age: 21),
                           User(name: "Alex", age: 21),
                           User(name: "Alex", age: 23)
                           ])
    }
    
    func remove(){
        list.value = [] //빈 배열로 덮어쓰기
    }
    
    func removeOneUser(at index: Int){
        list.value.remove(at: index)
    }
    
    func insertUser(name: String){
        let val = User(name: name, age: Int.random(in: 10...70))
        list.value.insert(val, at: Int.random(in: 0...2))
    }
  
}
