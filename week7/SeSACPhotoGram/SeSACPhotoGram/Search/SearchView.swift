//
//  SearchView.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/28.
//

import UIKit

class SearchView: BaseView{
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력하세요"
        return view
    }()
    
    lazy var collectionView = {
        //frame과 layout 워닝을 따로 알려주지 않으니 주의해야함
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        let size = (UIScreen.main.bounds.width - 20) * 0.33
        
        layout.itemSize = CGSize(width: size, height: size)
//        layout.minimumLineSpacing = 8
//        layout.minimumInteritemSpacing = 8
        view.collectionViewLayout = layout
        return view
    }()
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)//이거 view safearea 로 어떻게 바꾸지?
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
        
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: size/4, height: size/4)
        return layout
    }
}
