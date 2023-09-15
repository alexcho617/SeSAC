//
//  SampleViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/12.
//

import UIKit

//Model
class User: Hashable, Equatable{
    
    //Equatable
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    //Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID().uuidString
    let name: String
    let age: Int
    
    //data process
    var introduce: String{
        return "\(name), \(age) 살"
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class SampleViewController: UIViewController {
    let viewModel = SampleViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var n1 = 10
        var n2 = 3
        print(n1 - n2) //7
        
        n1 = 3
        n2 = 1
        
        var n3 = Observable(10)
        var n4 = Observable(3)
        
        n3.bind { n in
            print("n:",n)
            print("Observable", n3.value - n4.value)
        }
        
        n3.value = 5
        
        tableView.dataSource = self
        tableView.delegate = self

    }
}

extension SampleViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    //뷰에 보여주기만 한다
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration() //구조체이다. let을 사용하여 내부 프로퍼티를 변경할수 없다.
        content.text = "Text"
        content.secondaryText = "Hello \(indexPath.row)"
        cell.contentConfiguration = content //타입으로써의 프로토콜
        return cell
    }
}
