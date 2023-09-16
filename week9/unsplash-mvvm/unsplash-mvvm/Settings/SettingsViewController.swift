//
//  SettingsViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/16.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    let listOne = ["방해 금지 모드", "수면", "업무", "개인 시간"]
    let listTwo = ["모든 기기에서 공유"]
    
    enum Section: Int, CaseIterable {
        case first,second
    }
    
    //collectionview
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: getCVLayout())
        return view
    }()
    //datasource
    var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    //snapshot
    var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "집중 모드"
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        //MARK: didSelectItemAt
        collectionView.delegate = self
        setDataSource()
        applyData()
    }
    
    func applyData(){
        snapshot.appendSections([Section.first.rawValue, Section.second
            .rawValue])
        snapshot.appendItems(listOne, toSection: Section.first.rawValue)
        snapshot.appendItems(listTwo, toSection: Section.second.rawValue)
        dataSource.apply(snapshot)
    }
    
    func setDataSource(){
        //Registration
        let cellRegi = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            var contentConfig = UIListContentConfiguration.valueCell()
            contentConfig.text = itemIdentifier
            contentConfig.image = UIImage(systemName: "star")
            cell.contentConfiguration = contentConfig
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .systemBackground
            cell.backgroundConfiguration = backgroundConfig
        }
        
        //DataSource
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegi, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func getCVLayout() -> UICollectionViewLayout{
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }

}

//MARK: didSelectItemAt
extension SettingsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
