//
//  PhotoViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/12.
//

import UIKit

class PhotoViewController: UIViewController {
    let vm = PhotoViewModel()
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        print(#file)
        super.viewDidLoad()
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        
        vm.list.bind { _ in
            self.updateSnapshot()
           
        }
        
    }
    
    private func updateSnapshot(){
        //MARK: 여기서 계속 에러가 나네... section identifier 때문인것 같다
        snapshot.appendSections([0])
        snapshot.appendItems(vm.list.value.results!, toSection: 0)
    }
    private func configureDataSource(){
        let cellregi = UICollectionView.CellRegistration<UICollectionViewListCell,PhotoResult> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    //MARK: 시점이 중요
                    cell.contentConfiguration = content

                }
                
            }
            
            
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellregi, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    
    private func createLayout() -> UICollectionViewLayout{
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped) //Looks like tableview
        config.showsSeparators = false
        config.backgroundColor = .secondarySystemBackground
        var layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
}

extension PhotoViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        vm.fetchPhoto(text: searchBar.text!)
        print(searchBar.text!)
    }
}
