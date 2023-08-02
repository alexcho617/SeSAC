//
//  TodoInformation.swift
//  tableView
//
//  Created by Alex Cho on 2023/08/01.
//

import UIKit

struct ToDo{
    var mainText: String
    var subText: String
    var isLiked: Bool
    var isDone: Bool
    var color: UIColor
    
}
struct TodoManager{
    var todoList = [ //instance property
        ToDo(mainText: "Sleep", subText: "all night", isLiked: false, isDone: false, color: randomBackgroundColor()),
        ToDo(mainText: "Love", subText: "forever", isLiked: true, isDone: true, color: randomBackgroundColor()),
        ToDo(mainText: "Eat", subText: "the sauce", isLiked: false, isDone: true, color: randomBackgroundColor()),
    ]

    //random color - instance method
    static func randomBackgroundColor() -> UIColor{
        let color = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: .random(in: 0.5...1))
        return color
    }
}
