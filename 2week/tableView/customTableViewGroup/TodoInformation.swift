//
//  TodoInformation.swift
//  tableView
//
//  Created by Alex Cho on 2023/08/01.
//

import Foundation

struct ToDo{
    var mainText: String
    var subText: String
    var isLiked: Bool
    var isDone: Bool
    
}
struct TodoManager{
    var todoList = [
        ToDo(mainText: "Sleep", subText: "all night", isLiked: false, isDone: false),
        ToDo(mainText: "Love", subText: "forever", isLiked: true, isDone: true),
        ToDo(mainText: "Eat", subText: "the sauce", isLiked: false, isDone: true),
    ]

}
