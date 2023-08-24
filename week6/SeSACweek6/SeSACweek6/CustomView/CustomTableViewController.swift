//
//  CustomTableViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/24.
//

import UIKit
import SnapKit

struct DataSample{
    var text: String{
        let num = Int.random(in: 3...20)
        var text = "Cell Text"
        for _ in 0...num{
            text += "Cell Text"
        }
        return text
    }
    var isExpand: Bool{
        return Bool.random()
    }
}

class CustomTableViewController: UIViewController {
    var list = [DataSample(),DataSample(),DataSample(),DataSample(),DataSample(),DataSample()]
    private var isExpand = false
    private let tableView = {
        let view = UITableView()
        
        view.rowHeight = UITableView.automaticDimension
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //MovieCell.self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell") //cell 클래스 그 자체
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 0 0 0 0
        }

    }
}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource{
    //internal 은 뭐지?
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //System Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") else{return UITableViewCell()}
        
     
        cell.textLabel?.text = list[indexPath.row].text
        cell.textLabel?.numberOfLines = list[indexPath.row].isExpand ? 0 : 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isExpand.toggle()
        tableView.reloadData()
    }
}
