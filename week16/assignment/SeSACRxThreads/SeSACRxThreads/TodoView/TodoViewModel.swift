//
//  TodoViewModel.swift
//  SeSACRxThreads_Asgnmt
//
//  Created by Alex Cho on 2023/11/04.
//

import Foundation
import RxSwift
import RxCocoa

class TodoViewModel{
    let bag = DisposeBag()
    let todoTitle = BehaviorSubject<String>(value: "")

    var todoData: [TodoModel] = [
        TodoModel(title: "aaa", isDone: false, isFavorite: false),
        TodoModel(title: "bbb", isDone: false, isFavorite: false),
        TodoModel(title: "ccc", isDone: false, isFavorite: false),
    ]
    
    lazy var todoItems = BehaviorSubject(value: todoData)
    
    init() {
        //출력용
        todoTitle.bind(with: self) { owner, value in
            print("vm",value)
        }.disposed(by: bag)
    }
    
    
    func addTodo(title: String){
        let newTodo = TodoModel(title: title, isDone: false, isFavorite: false)
        todoData.append(newTodo)
        todoItems.onNext(todoData)
    }
    
    deinit {
        print(#function, "TodoVM")
    }
}

struct TodoModel{
    var title: String
    var isDone: Bool
    var isFavorite: Bool
}
