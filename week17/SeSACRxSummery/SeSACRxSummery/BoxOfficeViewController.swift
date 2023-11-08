//
//  ViewController.swift
//  SeSACRxSummery
//
//  Created by jack on 2023/11/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BoxOfficeViewController: UIViewController {
    
    let tableView = UITableView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout() )
    let searchBar = UISearchBar()
    
    let recent = BehaviorRelay(value: ["4","5","6"]) //collectionview 클릭한 것
    
    let items = PublishSubject<[DailyBoxOfficeList]>() //서버통신 결과
    
    let disposeBag = DisposeBag()
    var nickname = BehaviorSubject(value: "Alex")
    
    let vm = BoxOfficeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindInOut()
        
    }
    
    func bindInOut() {
        let recentText = PublishSubject<String>()
        let input = BoxOfficeViewModel.Input(searchButtonClicked: searchBar.rx.searchButtonClicked, query: searchBar.rx.text.orEmpty, recentText: recentText)
        
        let output = vm.transform(input: input)
        
        //items은 서브젝트라 이벤트가 3개지만 드라이브는 1개이기 때문에 잘 안맞음
        output.items.bind(to: tableView.rx.items(cellIdentifier: "MovieCell", cellType: UITableViewCell.self)){ row, element, cell in
            cell.textLabel?.text = element.movieNm
        }.disposed(by: disposeBag)
        
        
        output.recentList
//            .asDriver(onErrorJustReturn: []) //Driver<[String]>
            .bind(to: collectionView.rx.items(cellIdentifier: "MovieCollectionCell", cellType: MovieCollectionViewCell.self)){ row, element, cell in
            cell.label.text = element
        }.disposed(by: disposeBag)
        
        //zip에서 itemselected + modelselected였기 때문에 data는 셋이고 (indexPath, String)이 들어가있다
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(DailyBoxOfficeList.self))
            .map{ $0.1.movieNm }
//            .debug()
            .subscribe(with: self) { owner, data in
                //action을 어느정도 가공해서 보내도 괜찮다.
                recentText.onNext(data)
//                var temp = owner.recent.value//relay에선 추상화를 한번 더 했을 뿐
//                temp.append(data)
//                owner.recent.accept(temp) //Relay -> Accept
                
            }.disposed(by: disposeBag)
        
        
    }
    
    func bindOld() {
        //items은 서브젝트라 이벤트가 3개지만 드라이브는 1개이기 때문에 잘 안맞음
        items.bind(to: tableView.rx.items(cellIdentifier: "MovieCell", cellType: UITableViewCell.self)){ row, element, cell in
            cell.textLabel?.text = element.movieNm
        }.disposed(by: disposeBag)
        
        //relay니까 drive를 써보자
        recent
            .asDriver() //Driver<[String]>
            .drive(collectionView.rx.items(cellIdentifier: "MovieCollectionCell", cellType: MovieCollectionViewCell.self)){ row, element, cell in
            cell.label.text = element
        }.disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .withLatestFrom(searchBar.rx.text.orEmpty, resultSelector: { $1 })
            //validation 가능
            .map{ text -> Int in
                guard text.count == 8, let newText = Int(text) else {return 20231106}
                return newText
            }
            .flatMap{ date in
                BoxOfficeNetwork.fetchBoxOfficeData(date: "\(date)")
            }
            .subscribe(with: self) { owner, movie in
                owner.items.onNext(movie.boxOfficeResult.dailyBoxOfficeList)
            }.disposed(by: disposeBag)
        
        //zip에서 itemselected + modelselected였기 때문에 data는 셋이고 (indexPath, String)이 들어가있다
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(DailyBoxOfficeList.self))
            .map{ $0.1.movieNm }
            .debug()
            .subscribe(with: self) { owner, data in
                var temp = owner.recent.value//relay에선 추상화를 한번 더 했을 뿐
                temp.append(data)
                owner.recent.accept(temp) //Relay -> Accept
            }.disposed(by: disposeBag)
        
        
    }
    
    func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.backgroundColor = .green
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        collectionView.backgroundColor = .red
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
    
}
