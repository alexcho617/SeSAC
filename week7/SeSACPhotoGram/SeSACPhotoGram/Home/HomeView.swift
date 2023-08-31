//
//  HomeView.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/31.
//
import SnapKit
import UIKit

//protocol HomeViewProtocol {
protocol HomeViewProtocol: AnyObject{
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeView: BaseView{

    //'weak' must not be applied to non-class-bound 'any HomeViewProtocol'; consider adding a protocol conformance that has a class bound
    //weak은 클래스에서만 써야하는데 프로토콜에서 클래스 제약을 안걸었기 때문에 구조체 등 다른것들이 올 수 있어서 에러가남
    weak var delegate: HomeViewProtocol?
   
    lazy var collectionView = {
        //frame과 layout 워닝을 따로 알려주지 않으니 주의해야함
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        let size = UIScreen.main.bounds.width - 32 //(n * padding)
        layout.itemSize = CGSize(width: size/3, height: size/3)
        return layout
    }
    
    
    
    override func configureView() {
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}


extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.backgroundColor = .systemRed
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        //어떠한 navigation 불가: View Controller가 담당하고 있기 때문
        //delegate pattern을 사용한 값 전달
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
    
    
}
