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
    var isExpand: Bool = false
}

class CustomTableViewController: UIViewController {

    let imageView = {
        //여기서 설정해도 밑에 Constraint으로 잡아주기 때문에 별 의미는 없다
        let view = PosterImageView(frame: .zero)
        return view
    }()
    
//    let imageView = PosterImageView(frame: .zero)
    var list = [DataSample(),DataSample(),DataSample(),DataSample()]
    
    //vdl 전에 closure 실행함
    //따라서 CustomTableViewController 인스탄스 생성 직전에 클로저 구문이 우선 실행
    //그렇기 때문에 lazy를 써서 지연생성을 해야 delegate = self를 사용 할 수 있음
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.delegate = self //자신의 인스턴스를 의미
        view.dataSource = self
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell") //cell 클래스 그 자체
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            print("Constraints")
            make.size.equalTo(200)
            make.center.equalTo(view)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomTableViewCell else { return UITableViewCell() }
        
     
        cell.label.text = list[indexPath.row].text
        cell.label.numberOfLines = list[indexPath.row].isExpand ? 0 : 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.list[indexPath.row].isExpand.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
