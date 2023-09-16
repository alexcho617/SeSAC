//
//  SimpleCollectionViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/14.
//

import UIKit
import SnapKit
private let reuseIdentifier = "Cell"


class SimpleCollectionViewController: UIViewController {
    enum Section: Int, CaseIterable{
        case first,second,third
    }
    var list = [User(name: "Alex", age: 21),
                User(name: "Alex", age: 21),
                User(name: "Al", age: 23)
                ]
    var list2 = [User(name: "Blex", age: 21),
                User(name: "Blex", age: 21),
                User(name: "Blex", age: 23)
                ]
    
    var list3 = [User(name: "Clex", age: 21),
                User(name: "Clex", age: 21),
                User(name: "Clex", age: 23)
                ]
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
//    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>! //system cell, Data
    var dataSource: UICollectionViewDiffableDataSource<String, User>! //Hashable
    var snapshot = NSDiffableDataSourceSnapshot<String, User>() //    var dataSource: UICollectionViewDiffableDataSource<Int, User>! 이거랑 맞춤

    var dataButton = {
        let view = UIButton()
        view.setTitle("Add Section", for: .normal)
        view.setTitleColor(UIColor.systemBlue, for: .normal)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(dataButton)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dataButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        dataButton.addTarget(self, action: #selector(dataClick), for: .touchUpInside)
        configureDataSource()  //적용

        //snapshot
        //        var snapshot = NSDiffableDataSourceSnapshot<Section, User>() //    var dataSource: UICollectionViewDiffableDataSource<Int, User>! 이거랑 맞춤
        //열거형으로 사용 section{case first = 0}
        //        snapshot.appendSections(Section.allCases) //찰칵 섹션추가
        //        snapshot.appendItems(list, toSection: Section.first)
        //        snapshot.appendItems(list2, toSection: Section.second)
        
        snapshot.appendSections(["mysection1", "mysection2", "mysection3"]) //찰칵 섹션추가
        snapshot.appendItems(list, toSection: "mysection1")  //찰칵 로우 추가
        dataSource.apply(snapshot)
    }
    
    fileprivate func createLayout() -> UICollectionViewLayout{
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.showsSeparators = false
        config.backgroundColor = .secondarySystemBackground
        var layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    fileprivate func configureDataSource() {
       
        
        //UICollectionview cellregistration
        //ios 14+ 메소드 대신 제네릭 사용, 셀 생성될때마다 handler 클로저 호출
        //Registration 생성 및 초기화 동시 진행
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell,User>{ cell, indexPath, itemIdentifier in
            //cell design
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            content.secondaryText = String(itemIdentifier.age)
            content.image = UIImage(systemName: "star.fill")
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 40
            cell.contentConfiguration = content
            
            var bgconfig = UIBackgroundConfiguration.listPlainCell()
            
            bgconfig.cornerRadius = 10
            bgconfig.strokeWidth = 2
            bgconfig.strokeColor = .systemPink
            cell.backgroundConfiguration = bgconfig
        }
        //Diffable Datasource
        //CellForItemAt 이랑 비슷
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
            
        })

    }
    
    @objc func dataClick(){
        snapshot.appendItems(list2, toSection: "mysection2")  //찰칵 로우 추가
        snapshot.appendItems(list3, toSection: "mysection3")
        dataSource.apply(snapshot)
    }
}

//MARK: Diffable Data Source


//extension SimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//    //MARK: DataSource is still using old method.
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
//        return cell
//
//    }
//
//
//}
