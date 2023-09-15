//
//  SimpleTableViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/14.
//

import UIKit

class SimpleTableViewController: UITableViewController {
    
    var list = [User(name: "Alex", age: 21),
                User(name: "Alex", age: 21),
                User(name: "Clex", age: 23)
                ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = cell.defaultContentConfiguration()
        config.text = list[indexPath.row].name
        config.secondaryText = String(list[indexPath.row].age)
        cell.contentConfiguration = config
        return cell
    }


}
