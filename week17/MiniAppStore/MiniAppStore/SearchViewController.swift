//
//  ViewController.swift
//  MiniAppStore
//
//  Created by Alex Cho on 2023/11/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

class SearchViewController: UIViewController {
    private let tableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .systemBackground
        view.separatorStyle = .none
        view.rowHeight = 180
        return view
    }()
    
    let searchBar = UISearchBar()
    let vm = SearchViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        bind()
    }
    
    func bind(){
        vm.items.bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) {row,element,cell in
            cell.appNameLabel.text = element.trackName
            cell.appIconImageView.kf.setImage(with: URL(string: element.artworkUrl512))
            
        }.disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(searchBar.rx.text.orEmpty) {$1}
            .distinctUntilChanged()
            .flatMap { query in
                APIManager.fetchData(query: query)
            }
            .subscribe(with: self) { owner, appstoreModel in
                owner.vm.items.onNext(appstoreModel.results)
            }.disposed(by: disposeBag)
    }
    
    private func setView(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(searchBar)
        self.navigationItem.titleView = searchBar
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

