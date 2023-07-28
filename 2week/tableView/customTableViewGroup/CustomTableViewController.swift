//
//  CustomTableViewController.swift
//  tableView
//
//  Created by Alex Cho on 2023/07/28.
//

import UIKit

struct ToDo{
    var mainText: String
    var subText: String
    var isLiked: Bool
    var isDone: Bool
}

class CustomTableViewController: UITableViewController {
    //Manager class abstraction
    var todoList = [
        ToDo(mainText: "Sleep", subText: "all night", isLiked: false, isDone: false),
        ToDo(mainText: "Love", subText: "forever", isLiked: true, isDone: true),
        ToDo(mainText: "Eat", subText: "the sauce", isLiked: false, isDone: true),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //에러나면 여기서 아이덴티파이어 미스매칭일 경우가 높음
        //Q:근데 이런식이 아니라 TableViewCell파일에서 이니셜라이즈해서 반환하는게 더 자연스러울것 같은데 애플 코드가 이래서 따라 갈 수 밖에 없는건가?
        //A:as!로 변환하는게 이미 인스탄스를 생성한것?
        /*
         이게 그럼 순서가 일단 UITAbleviewcell로 일단 만들어둔 다음에 as!로
         downcasting을 한건데 downcasting이란건 기존 클래스의 인스탄스를 자식 클래스로 생성하고 다시 어사인 하는게 아니라 그렇게 사용할 수 있게끔 하는거다.
         */
        let row = todoList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
      
        cell.setCell(row: row)
        return cell
    }
    //cell select
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
   
}
