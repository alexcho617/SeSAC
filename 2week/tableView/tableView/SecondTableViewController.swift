//
//  SecondTableViewController.swift
//  tableView
//
//  Created by Alex Cho on 2023/07/27.
//

import UIKit

class SecondTableViewController: UITableViewController {
    let sectionData = ["전체 설정","개인 설정","기타"]
    let rowData = [
        ["공지사항","실험실","버전 정보"],
        ["개인/보안","알림","채팅","멀티프로필"],
        ["고객센터/도움말"]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell") else {
            print("no cell found")
            return UITableViewCell()
        }
        cell.textLabel?.text = rowData[indexPath.section][indexPath.row]
        return cell
    }
    
}
