//
//  TodoViewController.swift
//  PhotoGramRealm
//
//  Created by Alex Cho on 2023/09/08.
//

///
///Tableview Editing Mode 실습
import UIKit
import RealmSwift
import SnapKit
class TodoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    let realm = try! Realm()
    var list: Results<TodoTable>!
    let tableView = UITableView()
    let editButton = {
        let view = UIButton()
        view.setTitle("편집", for: .normal)
        view.setTitleColor(UIColor.systemBlue, for: .normal)

        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        list = realm.objects(TodoTable.self)
    }
    
    @objc func tap(){
        let isEditing = !tableView.isEditing
        print(#function)
        tableView.setEditing(isEditing, animated: true)
        editButton.isSelected = isEditing
        editButton.setTitle(isEditing ? "완료" : "편집", for: .normal)
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") else {return UITableViewCell()}
        let row = list[indexPath.row]
        cell.textLabel?.text = "\(row.title): 서브 테스크\(row.detail.count)개"
        return cell
    }
    
    func setView(){
        view.backgroundColor = .systemBackground
        view.addSubview(editButton)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
       
        editButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        editButton.addTarget(self, action: #selector(tap), for: .touchUpInside)

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

//MARK: Delete
extension TodoViewController {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        try! realm.write{
            realm.delete(list[indexPath.row])
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

//MARK: Move
extension TodoViewController{
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath)
        print(destinationIndexPath)
        //update to realm
        
    }
}
