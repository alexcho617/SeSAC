//
//  DetailViewController.swift
//  tableView
//
//  Created by Alex Cho on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {
    //1
    var data: ToDo?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let data else {return}
        print(data)

    }
    
}
