//
//  RxDatasourceListViewController.swift
//  SeSACRxSummery
//
//  Created by Alex Cho on 2023/11/08.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

struct Ment{
    let word: String
    let count: Int
}

struct Mentor:  SectionModelType{
    typealias Item = Ment //Generic에 클래스, 프로토콜 제한이랑 유사
    
    var name: String
    var items: [Ment]
    
   
}

//extension 안에 init구문을 넣어서 기본 init을 덮어쓰지 않음
extension Mentor{
    init(original: Mentor, items: [Ment]) {
        self = original
        self.items = items
    }
}
class RxDatasourceListViewController: UIViewController {
    let tableview = UITableView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()

        
        //data
        let mentors = [
                
                Mentor(name: "Jack", items: [
                    Ment(word: "맛점하셧나여", count: 11),
                    Ment(word: "돌아오세여", count: 11),
                    Ment(word: "살아계신가여", count: 11)
                ]),
                Mentor(name: "Hue", items: [
                    Ment(word: "맛점하셧나여", count: 11),
                    Ment(word: "돌아오세여", count: 11),
                    Ment(word: "살아계신가여", count: 11)
                ]),
                Mentor(name: "Bran", items: [
                    Ment(word: "맛점하셧나여", count: 11),
                    Ment(word: "돌아오세여", count: 11),
                    Ment(word: "살아계신가여", count: 11)
                ]),
                Mentor(name: "Koko", items: [
                    Ment(word: "맛점하셧나여", count: 11),
                    Ment(word: "돌아오세여", count: 11),
                    Ment(word: "살아계신가여", count: 11)
                ])
                
        ]
        
        //define data source
        let dataSource = RxTableViewSectionedReloadDataSource<Mentor>(
          configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
              cell.textLabel?.text = "Item \(item.word): \(item.count)"
            return cell
        })
        
        //section header
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].name
        }
        
        //bind
        Observable.just(mentors)
            .bind(to: tableview.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func configure(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableview)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "ListCell")
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
