//
//  ViewController.swift
//  SearchExample
//
//  Created by jack on 2023/08/04.
//
 
import UIKit

class LibraryCollectionViewController: UICollectionViewController {
    
    let searchBar = UISearchBar()
    
    var list = MovieInfo()
    var searchList: [Movie] = []
     
    override func viewDidLoad() {
        super.viewDidLoad()
        //처음 앱 실행시 전체 데이터 보여주기
        searchList = list.movie
        configureSearchBar()
        collectionViewLayout()
 
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        //검색화면에서 보여주기
        //좋아요를 두개의 리스트에 반영해야함,
        //영화를 원본에서찾고 그 영화의 인덱스를 통해 토글해야함
        
        //1 타이틀 가져오기
        let title = searchList[sender.tag].title
        //2 원본 배열에서 영화 가져옴, enumerated 통해 인덱스를 가져옴
        for (index,item) in list.movie.enumerated(){
            //3몇번 배열에 있는지 확인 후 반영
            if item.title == title{
                list.movie[index].like.toggle()
            }
        }
        searchList[sender.tag].like.toggle()
        
        collectionView.reloadData()
        
    }
    //검색 내용이 없으면 전체 보여주자
    func searchQuery(text: String) {
        searchList.removeAll()
        for item in list.movie{
            if item.title.contains(text){
                searchList.append(item)
            }
        }
        if searchList.isEmpty{
            searchList = list.movie
        }
        collectionView.reloadData()

    }

}

extension LibraryCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchQuery(text: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        searchQuery(text: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         
        searchBar.text = ""
        searchList = list.movie
        collectionView.reloadData()
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
}

extension LibraryCollectionViewController {
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.movie.count
        return searchList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifier, for: indexPath) as! LibraryCollectionViewCell
        
        let data = searchList[indexPath.row]
        cell.configureCell(data: data)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    
}

extension LibraryCollectionViewController {
    
    static let identifier = "LibraryCollectionViewController"
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
    }
 
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요"
        navigationItem.titleView = searchBar
    }
    
}
