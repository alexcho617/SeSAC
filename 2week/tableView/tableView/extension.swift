//
//  extension.swift
//  tableView
//
//  Created by Alex Cho on 2023/07/27.
//

import Foundation
import UIKit


extension UITableViewController{
    func popUpAlert(){
        let alert = UIAlertController(title: "타이틀", message: "메시지", preferredStyle: .alert)
        let action = UIAlertAction(title: "HI", style: .default)
        alert.addAction(action)
        present(alert,animated: true)
        
    }
}

extension UILabel{
    func changeColorToGreen(){
        self.textColor = .green
    }
}
