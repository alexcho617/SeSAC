//
//  CustomTableViewController.swift
//  tableView
//
//  Created by Alex Cho on 2023/07/28.
//

import UIKit
/*
 1. 파티를 막자
 2. sender.tag
 */

class CustomTableViewController: UITableViewController {

    var todoManager = TodoManager() {
        //**달라진걸 감지
        //property observer didSet
        didSet{
            tableView.reloadData()
        }
        willSet{
            print("will set")
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        searchBar.placeholder = "검색"
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarReturnTapped), for: .editingDidEndOnExit)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoManager.todoList.count
    }
    
    //에러나면 여기서 아이덴티파이어 미스매칭일 경우가 높음
    //Q:근데 이런식이 아니라 TableViewCell파일에서 이니셜라이즈해서 반환하는게 더 자연스러울것 같은데 애플 코드가 이래서 따라 갈 수 밖에 없는건가?
    //A:as!로 변환하는게 이미 인스탄스를 생성한것?
    /*
     이게 그럼 순서가 일단 UITAbleviewcell로 일단 만들어둔 다음에 as!로
     downcasting을 한건데 downcasting이란건 기존 클래스의 인스탄스를 자식 클래스로 생성하고 다시 어사인 하는게 아니라 그렇게 사용할 수 있게끔 하는거다.
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = todoManager.todoList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
      
        cell.setCell(row: row)
        //ibaction으로 설정하면 안됨
        cell.likeButton.tag = indexPath.row //고유하게 인식 됨
        cell.likeButton.addTarget(self, action: #selector(cellLikeClicked), for: .touchUpInside) //IB안쓰고 코드베이스로 설정함
        return cell
    }
    
    @objc func searchBarReturnTapped(){
        if let text = searchBar.searchTextField.text{
            if !text.isEmpty{
                let newItem = ToDo(mainText: text, subText: "23.08.01", isLiked: false, isDone: false, color: TodoManager.randomBackgroundColor())
                
                todoManager.todoList.insert(newItem, at: 0)
//                tableView.reloadData()
                view.endEditing(true)
                searchBar.searchTextField.text = nil
            }else{
                print("empty")
                
            }
        }
    }
    
    
    //todo isLiked toggle
    @objc
    func cellLikeClicked(_ sender: UIButton){
        todoManager.todoList[sender.tag].isLiked.toggle()
//        tableView.reloadData()
    }
    
    //cell select: 화면 전환
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        todoManager.todoList[indexPath.row].isDone.toggle()
        let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        vc.data = todoManager.todoList[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .none)
        present(vc, animated: true)
    }
    
    //cell delete
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //delete
        todoManager.todoList.remove(at: indexPath.row)
        print(todoManager.todoList)
        print(todoManager.todoList.count)
        //update
//        tableView.reloadData()
    }
   
}
