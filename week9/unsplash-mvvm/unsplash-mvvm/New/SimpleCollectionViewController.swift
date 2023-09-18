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
    enum Section: Int{
        case one,twi
    }
    
    var vm = SimpleCollectionViewModel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    var dataSource: UICollectionViewDiffableDataSource<Section, User>! //Hashable
    var snapshot = NSDiffableDataSourceSnapshot<Section, User>() //    var dataSource: UICollectionViewDiffableDataSource<Int, User>! 이거랑 맞춤

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        snapshot.appendSections([Section.one]) //찰칵 섹션추가

        configureDataSource()  //적용

        updateSnapshot()
        vm.list.bind { user in
            self.updateSnapshot()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){ [self] in
            self.vm.append()
            dataSource.apply(snapshot)
        }
    }
    
    func updateSnapshot(){
        snapshot.appendItems(vm.list.value, toSection: Section.one)  //찰칵 로우 추가
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
}

extension SimpleCollectionViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else {return}
        dump(item)
        vm.removeOneUser(at: indexPath.item)
    }
}

extension SimpleCollectionViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        vm.insertUser(name: searchBar.text!)
    }
}
