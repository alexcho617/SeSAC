//
//  SearchViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/28.
//
import UIKit
import Alamofire
import Kingfisher

class SearchViewController: BaseViewController {
    private var unsplash: Unsplash?
    let mainView = SearchView()
    
    //2
    var delegate: PassImageDelegate?
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Search VDL")
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    func callRequest(query: String){
        APIService.shared.callRequestWithAF(query: query) { response in
            self.unsplash = response.value
            self.mainView.collectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        unsplash?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        let item = unsplash?.results[indexPath.item]
        cell.imageView.kf.setImage(with: URL(string: item?.urls.regular ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //notification 방식
        NotificationCenter.default.post(name: .selectImage, object: nil, userInfo: ["name": unsplash?.results[indexPath.item].urls.regular, "sample": "고래밥"])
        
        //delegate 방식
//        let name = imageList[indexPath.item]
//        print(name)
//        //3
//        delegate?.passImage(image: name)
        
//        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text{
            callRequest(query: query)
        }
        mainView.searchBar.resignFirstResponder()
    }
}
