//
//  SettingsTwoViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/16.
//

import UIKit
import SnapKit
class SettingsTwoViewController: UIViewController {
    enum Section: Int, CaseIterable{
        case First, Second, Third
    }
    let sectionData = [["공지사항", "실험실", "버전 정보"],["개인/보안", "알림", "채팅", "멀티프로필"],["고객센터/도움말"]]
    
    //CV Declare and Init
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
    //DS Declare
    var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    //SS Declare and Init
    var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "설정"
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        setDataSource()
        applySnapshot()

    }
    
    static func getLayout() -> UICollectionViewLayout{
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    func setDataSource(){
        //Cell Register
        let cellReg = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            
            var contentConfig = UIListContentConfiguration.cell()
            contentConfig.text = itemIdentifier //String
            contentConfig.image = UIImage(systemName: "pencil")
            cell.contentConfiguration = contentConfig
        }
        
        //Data Source
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellReg, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func applySnapshot(){
        snapshot.appendSections([Section.First.rawValue, Section.Second.rawValue, Section.Third.rawValue])
        for (index, section) in Section.allCases.enumerated(){
            snapshot.appendItems(sectionData[index], toSection: section.rawValue)
        }
        dataSource.apply(snapshot)
    }


}
