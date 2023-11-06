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
import Kingfisher

class SearchViewController: UIViewController {
     
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    
    let searchBar = UISearchBar()
    var data: [AppInfo] = []
//    var data = ["1","2","3","4","5","11","111","1234","아","이언"] //데이터를 따로 관리 해서 item에 주입
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        bind()
//        setSearchController()
        
    }
    func bind(){
        items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element.trackName
                cell.appIconImageView.backgroundColor = .green
                cell.appIconImageView.kf.setImage(with: URL(string: element.artworkUrl512))
                //reusable mechanism에 의해 버튼에 구독이 계속 늘어나고 있음 -> cell preparefor reuse에서 dispose bag instance 갈아끼워서 해결
                cell.downloadButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        owner.navigationController?.pushViewController(SampleVC(), animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        //1 subscribe: share, observeOn
        //2 bind: share
        //3 drive
        
        let request = BasicAPIManager.fetchData().asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
        
        request.drive(with: self) { owner, result in
            owner.items.onNext(result.results)
        }.disposed(by: disposeBag)
        
        request.map {data in
            "\(data.results.count)개의 검색 결과"
        }
        .drive(navigationItem.rx.title)
        .disposed(by: disposeBag)
    }
    
//
//    func bind_old() {
//        //cellfor row at
//        items
//            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
//                cell.appNameLabel.text = element
//                cell.appIconImageView.backgroundColor = .green
//                //reusable mechanism에 의해 버튼에 구독이 계속 늘어나고 있음
//                cell.downloadButton.rx.tap
//                    .subscribe(with: self) { owner, _ in
//                        owner.navigationController?.pushViewController(SampleVC(), animated: true)
//                    }
//                    .disposed(by: cell.disposeBag)
//            }
//            .disposed(by: disposeBag)
//
//        //cell select1, returns indexpath
////        tableView.rx.itemSelected
////            .subscribe(with: self) { owner, indexPath in
////                print(indexPath) //[0, 0]
////
////            }.disposed(by: disposeBag)
//
//        //cell select2, returns data
////        tableView.rx.modelSelected(String.self)
////            .subscribe(with: self) { owner, indexPath in
////                print(indexPath) //안녕하세요 100
////            }.disposed(by: disposeBag)
////
//        //indexpath, data따로 주는걸 결합
//        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self))
//            .map {"Cell Selected \($0), \($1)"}
//            .bind(to: navigationItem.rx.title)
////            .subscribe(with: self) { owner, value in
////                print(value)
////            }
//        .disposed(by: disposeBag)
//
//        //기존
//        //uisearchbardelegate, searchbarsearchbuttonclicked
//        //searchbar text 를 배열에 추가, 리턴키 클릭시
//        //text optional binding -> append -> tableview reloaddata
//
//        //rx
//        searchBar.rx.searchButtonClicked //void
//        //다른 옵저버블과 결합. 보통 버튼 클릭시 넘어갈때 데이터를 같이 넘기기 위해 사용
//            .withLatestFrom(searchBar.rx.text.orEmpty){ void, text in
//                return text
//            }//now string
//            .subscribe(with: self) { owner, text in //void인 이유는 클릭한 액션 그 자체임. stream 이 string을 전하지 않음. withlatestfrom에서 결합해서 string으로 바뀜
//                print("Searched",text)
//                owner.data.append(text)
//                owner.data.insert(text, at: 0)
//                owner.items.onNext(owner.data) //데이터는 따로이기 때문에 바뀔때 주입 하면 됨
//            }.disposed(by: disposeBag)
//
//        //실시간 검색
//        searchBar.rx.text.orEmpty //서치바 내용 withLatestFrom으로 결합
//            //입력을 하다 시간이 좀 지나서 기다릴때 검색을 해보자
//            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
//
//            //직전에 입력한 같은 경우 호출은 하지 말아보자 (썼다가 지웠다 한 경우)
//            .distinctUntilChanged()
//            .subscribe(with: self) { owner, value in
//
//
//                //이렇게 하면 아무것도 입력하지 않았을땐 결과가 없음,
//                let result = value == "" ? owner.data : owner.data.filter { $0.contains(value) }
//                owner.items.onNext(result)
//                print("--실시간 검색--",result)
//
//            }.disposed(by: disposeBag)
//
//    }
//
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
