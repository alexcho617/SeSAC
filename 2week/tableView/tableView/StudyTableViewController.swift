//
//  StudyTableViewController.swift
//  tableView
//
//  Created by Alex Cho on 2023/07/27.
//

import UIKit

class StudyTableViewController: UITableViewController {
    let studyList = ["Variables","Constants","Enumeration","Optional Binding","Method","Property"]
    let choreList = ["Wash Dishes","Laundry","Grocery Shopping"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //100프로 케이스 대응
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Study List" : "Chore List"
    }
    //1
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? studyList.count : choreList.count
                
    }
    //2
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") else {
            print("no cell found")
            return UITableViewCell()
        }
        
        
        cell.textLabel?.text = indexPath.section == 0 ? studyList[indexPath.row] : choreList[indexPath.row]
        
        
        return cell
    }
    //3 dynamic height 이면 필요하지만 height이 고정이면 호출 할 이유가 없음
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//
//        return CGFloat(indexPath.row * 50)
//    }
}
