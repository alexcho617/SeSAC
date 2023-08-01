//
//  SettingTableViewController.swift
//  OneLineDiary
//
//  Created by Alex Cho on 2023/08/01.
//

import UIKit
enum SettingOptions: Int, CaseIterable{
    
    case total, personal, others
    
    var mainOptions: String{
        get{//겟만 쓸땐 생략가능
            switch self {
            case .total: return "Total"
            case .personal: return "Personal"
            case .others: return "Other"
            }
        }
    }
    
    var subOptions: [String]{
        switch self {
        case .total: return ["공지사항", "실험실", "버전 정보"]
        case .personal: return ["개인/보안","알림","채팅","멀티프로필"]
        case .others: return   ["고객센터","1대1 채팅"]
        }
    }
}

class SettingTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOptions.allCases[section].subOptions.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].mainOptions
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell")!
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].subOptions[indexPath.row]
        
        return cell
    }
}
