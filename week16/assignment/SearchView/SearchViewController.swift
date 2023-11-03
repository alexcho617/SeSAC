//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/11/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
     
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 80
        view.separatorStyle = .none
       return view
     }()
    
    let searchBar = UISearchBar()
    var data = ["1","2","3","4","11"]
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setSearchController()
        bind()
        
    }
    
     
    func bind() {
        items.bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)){ (row,element,cell) in
            cell.appNameLabel.text = element
            cell.appIconImageView.backgroundColor = .green
            cell.downloadButton.rx.tap
                .subscribe(with: self) { owner, _ in
                    owner.navigationController?.pushViewController(SampleVC(), animated: true)
                }.disposed(by: cell.disposeBag)
        }
        .disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self))
            .map {"Cell Selected \($0), \($1)"}
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty) { _, text in
                return text
            }
            .subscribe(with: self) { owner, text in
                owner.data.insert(text, at: 0)
                owner.items.onNext(owner.data)
            }
            .disposed(by: disposeBag)

        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance) //singleton instance
            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                
                let result = value == "" ? owner.data : owner.data.filter{ $0.contains(value)}
                owner.items.onNext(result)
                print("Realtime search with", value, result)
            }.disposed(by: disposeBag)
       
    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        self.navigationItem.titleView = searchBar
    }

    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}


class SampleVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        title = "\(Int.random(in: 0...10))"
    }
}
