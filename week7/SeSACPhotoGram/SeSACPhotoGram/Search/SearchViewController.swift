//
//  SearchViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {
    let mainView = SearchView()
    let imageList = ["pencil","star","person","star.fill","xmark","person.circle"]
    //2
    var delegate: PassImageDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Search VDL")
        NotificationCenter.default.addObserver(self, selector: #selector(recommendKeyObserver), name: NSNotification.Name("RecommendKey"), object: nil)
        
    }
    
    //B->A는 되었는데 A->B는 안되고 있는상황: 포스트 전에 옵저빙을 하고 있어야하기 때문에 받을 수 없다. 따라서 일반적으로 Notification은 B->A상황에서만 쓴다.
    @objc func recommendKeyObserver(notification: NSNotification){
        print(#function)
        print("GOT REC")
        //sleep을 줘도 아에 그냥 실행이 안되는데?
        //dispatchqueue로 넘어와도 안됨
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.imageView.image = UIImage(systemName: imageList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //notification 방식
//        NotificationCenter.default.post(name: .selectImage, object: nil, userInfo: ["name": imageList[indexPath.item], "sample": "고래밥"])
        
        //delegate 방식
        let name = imageList[indexPath.item]
        print(name)
        //3
        delegate?.passImage(image: name)
        
        dismiss(animated: true)
    }
    
    
}
