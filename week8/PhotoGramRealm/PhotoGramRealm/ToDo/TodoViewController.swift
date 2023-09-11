//
//  TodoViewController.swift
//  PhotoGramRealm
//
//  Created by Alex Cho on 2023/09/08.
//

import UIKit
import RealmSwift
import SnapKit
class TodoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    let realm = try! Realm()
    let tableView = UITableView()
//    var list: Results<TodoTable>!
    var list: Results<DetailTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let data = TodoTable(title: "영화보기", favorite: false)
//        let memo = Memo()
//        memo.content  = "주말에 리캡 해야는데"
//        memo.date = Date()
//        data.memo = memo
//        try! realm.write{
//            realm.add(data)
//        }
//        let data = TodoTable(title: "장보기", favorite: true)
//        let detail1 = DetailTable(detail: "Onion", deadline: Date())
//        let detail2 = DetailTable(detail: "Ox", deadline: Date())
//        let detail3 = DetailTable(detail: "Ok", deadline: Date())
//
//        try! realm.write{
//            realm.add(data)
//            data.detail.append(detail1)
//            data.detail.append(detail2)
//            data.detail.append(detail3)
//        }
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        print(realm.configuration.fileURL as Any)
//        list = realm.objects(TodoTable.self)
        list = realm.objects(DetailTable.self)
        print(list)
//        createTodo()
        
//        let mainTodo = realm.objects(TodoTable.self).where {
//            $0.title == "Shop"
//        }.first!
//
//        for i in 1...10{
//            let data = DetailTable(detail: "Detail Task \(i)", deadline: Date())
//            try! realm.write{
//                mainTodo.detail.append(data)
//                realm.add(data)
//            }
//        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") else {return UITableViewCell()}
        let row = list[indexPath.row]
//        cell.textLabel?.text = "\(row.title): \(row.detail.count) - \(row.memo?.content)"
        cell.textLabel?.text = "\(row.detail) is in \(row.mainTodo.first?.title ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = list[indexPath.row]
//
//
//        try! realm.write{
//            //내부 디테일 테이블 먼저 지워야함
//            realm.delete(data.detail)
//            realm.delete(data)
//        }
//        tableView.reloadData()
    }
    
    func createTodo(){
        for i in ["Shop", "Watch Movie", "Do Recap", "Make Like Feature", " Sleep"]{
            let data = TodoTable(title: i, favorite: false)
            try! realm.write{
                realm.add(data)
            }
        }
    }
}

