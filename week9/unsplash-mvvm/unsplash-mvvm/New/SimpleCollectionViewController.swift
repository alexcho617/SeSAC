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
    var list = [User(name: "Alex", age: 21),User(name: "Blex", age: 22),User(name: "Clex", age: 23)]
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>! //system cell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //UICollectionview cellregistration
        //ios 14+ 메소드 대신 제네릭 사용, 셀 생성될때마다 handler 클로저 호출
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            //cell design
            //index 기반인건 매한가지같은데? -> Diffable Datasource를 사용해야함
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            content.secondaryText = String(itemIdentifier.age)
            content.image = UIImage(systemName: "star.fill")
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 40
            cell.contentConfiguration = content
            
            var bgconfig = UIBackgroundConfiguration.listPlainCell()
            bgconfig.backgroundColor = .gray
            bgconfig.cornerRadius = 10
            bgconfig.strokeWidth = 2
            bgconfig.strokeColor = .systemPink
            cell.backgroundConfiguration = bgconfig
        })
        
    }
    
    fileprivate func createLayout() -> UICollectionViewLayout{
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.showsSeparators = false
        config.backgroundColor = .secondarySystemBackground
        var layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
}

extension SimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    //MARK: DataSource is still using old method.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
        return cell
        
    }
    
    
}
