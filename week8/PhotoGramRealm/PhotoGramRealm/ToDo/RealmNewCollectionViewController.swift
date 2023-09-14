//
//  RealmNewCollectionViewController.swift
//  PhotoGramRealm
//
//  Created by Alex Cho on 2023/09/14.
//

import UIKit
import SnapKit
import RealmSwift

private let reuseIdentifier = "Cell"

final class RealmNewCollectionViewController: BaseViewController {
    
    private let realm = try! Realm()
    private var list: Results<TodoTable>!
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private var cellRegi: UICollectionView.CellRegistration<UICollectionViewCell, TodoTable>! //cell, data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm.configuration.fileURL)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.list = realm.objects(TodoTable.self)
//        /itemIdentifier = list[indexPath.item]
        cellRegi = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var config = UIListContentConfiguration.valueCell()
            config.text = itemIdentifier.title
            config.secondaryText = String(itemIdentifier.detail.count)
            config.image = UIImage(systemName: "pencil")
            cell.contentConfiguration = config
        })
        
    }
    
    private func layout() -> UICollectionViewLayout{
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config) //what is list for?
        return layout
    }
}

extension RealmNewCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = list[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegi, for: indexPath, item: data)
        return cell
    }
}
