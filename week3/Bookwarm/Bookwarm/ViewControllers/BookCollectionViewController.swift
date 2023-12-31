//
//  BookCollectionViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
final class BookCollectionViewController: UICollectionViewController {
    
    //variables
    private var page = 1
    private var isEnd = false
    private let searchBar = UISearchBar()
    private let searchPlaceHolder = "검색을 해보세요"
    private var bookList: [RealmBook] = []

    @IBOutlet weak var searchButton: UIBarButtonItem!
    //vdl
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.isHidden = true // 현재 안쓰는 기능
        navigationItem.titleView = searchBar //여기서 서치바 가운데에 놓았음
        searchBar.delegate = self
//        collectionView.prefetchDataSource = self
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        setLayout()
        setSearchBar()
    }
    
    
    //actions
    private func callRequest(query: String, page: Int){
        let headers: HTTPHeaders = ["Authorization": APIKey.kakaoKey]
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let size = 20
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=\(size)&page=\(page)"
        print(url)
        
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                //list
                self.isEnd = json["meta"]["is_End"].boolValue
                for item in json["documents"].arrayValue{
                    let book = RealmBook(
                        authors: item["authors"].arrayValue[0].stringValue,
                        title: item["title"].stringValue,
                        thumbnail: item["thumbnail"].stringValue,
                        url: item["url"].stringValue,
                        isLiked: false,
                        memo: nil
                    )
                    self.bookList.append(book)
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    //현재 안쓰는 기능
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
//        //storyboard
//
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//
//        //controllers
//        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
//        let nc = UINavigationController(rootViewController: vc)
//
//        //set
//        nc.modalPresentationStyle = .fullScreen
//        //navigate
//        present(nc, animated: true)
    }
    
    
    //functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else{
            print("failed to build cell")
            return UICollectionViewCell()
        }
        //configure cell
        let book = bookList[indexPath.row]
        
        cell.likeButton.tag = indexPath.row
        cell.setCell(row: book)
        cell.likeButton.addTarget(self, action: #selector(likeToggle), for: .touchUpInside)

        return cell
    }
    
    //TODO: Create ImageFile
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //create
        let data = bookList[indexPath.row]
        let book = RealmBook(authors: data.authors, title: data.title, thumbnail: data.thumbnailImageURL, url: data.webPageURL, isLiked: data.userDidLike, memo: nil)
        BookRealmRepository.shared.create(book)
        
        //imageurl -> data -> uiimage
        if let url = URL(string: data.thumbnailImageURL){
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.saveImageToDocument(filename: "\(book._id.stringValue).jpeg", image: UIImage(data: data)!)
                    print("image added")
                }
                
            }
            
            //use primary key as file name

        }
        
    }
    
    
    @objc func likeToggle(_ sender: UIButton){
        bookList[sender.tag].userDidLike.toggle()
    }
    
    private func setSearchBar(){
        searchBar.placeholder = searchPlaceHolder
        searchBar.showsCancelButton = true
    }
    
    private func setLayout(){
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let itemWidth = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
}

extension BookCollectionViewController: UISearchBarDelegate{
//실시간 검색되는거 해제
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        search()
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.resignFirstResponder()
        view.endEditing(true)
        bookList.removeAll()
        page = 1
        guard let query = searchBar.text else {return}
//        search()
        callRequest(query: query, page: page)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        bookList.removeAll()

        collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
 
}
//TODO: Scroll error due to Prefetching
//extension BookCollectionViewController: UICollectionViewDataSourcePrefetching{
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            if bookList.count - 1 == indexPath.row && page < 15 && !isEnd{
//                page += 1
//                callRequest(query: searchBar.text!, page: page)
//            }
//        }
//    }
//
//
//
//
//
//}
