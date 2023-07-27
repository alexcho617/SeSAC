//
//  TodoTableViewController.swift
//  tableView
//
//  Created by Alex Cho on 2023/07/27.
//

import UIKit

class TodoTableViewController: UITableViewController {
    enum CellKind: String{
        case settingCell = "settingCell"
    }
    var todoList = [
      "청소하기",
      "밥 먹기",
      "운동하기",
      "공부하기",
      "영화 보기",
      "산책하기",
      "음악 듣기",
      "커피 마시기",
      "친구 만나기",
      "책 읽기",
      "요리하기",
    ]
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        todoList.append("새로운 아이템")
        //refresh
        tableView.reloadData()
        scrollToTop()
        popUpAlert()
    }
    //3가지 필수
    //섹션 내 로우 갯수 시스템에게 전달: 친구 수 만큼
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    //셀 디자인 및 데이터 처리
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function,indexPath)
        
        //double ended que reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: CellKind.settingCell.rawValue)!
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .white
        
        
        cell.textLabel?.text = todoList[indexPath.row]
        cell.textLabel?.textColor = .red
        cell.textLabel?.font = .systemFont(ofSize: 20)
        
        //extension
        cell.detailTextLabel?.changeColorToGreen()
        cell.detailTextLabel?.text = "DETAIL"
    
        cell.imageView?.image = UIImage(systemName: "star.fill")
        
        return cell
    }
    
    //셀 높이 기본44
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    private func scrollToTop() {
        // 1
        let topRow = IndexPath(row: 0,
                               section: 0)
                               
        // 2
        self.tableView.scrollToRow(at: topRow,
                                   at: .top,
                                   animated: true)
    }
}
