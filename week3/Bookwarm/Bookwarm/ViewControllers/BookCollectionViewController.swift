//
//  BookCollectionViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit

class BookCollectionViewController: UICollectionViewController {
    
    let searchBar = UISearchBar()
    let searchPlaceHolder = "검색을 해보세요"
    //variables
    var movieInfo = MovieInfo(){
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    //vdl
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.isHidden = true // 현재 안쓰는 기능
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        setLayout()
        setSearchBar()
    }
    
    
    //actions
    
    //현재 안쓰는 기능
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        //storyboard
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        //controllers
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let nc = UINavigationController(rootViewController: vc)
        
        //set
        nc.modalPresentationStyle = .fullScreen
        //navigate
        present(nc, animated: true)
    }
    
    
    //functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieInfo.searchResults.isEmpty{
            return movieInfo.movies.count
        } else{
            return movieInfo.searchResults.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else{
            print("failed to build cell")
            return UICollectionViewCell()
        }
        //configure cell
        if movieInfo.searchResults.isEmpty{
            let movie = movieInfo.movies[indexPath.row]
            
            // Todo search 결과에서 눌렀을때 인덱스 오류로 인해 오작동함
            cell.likeButton.tag = indexPath.row
            cell.setCell(row: movie)
            cell.likeButton.addTarget(self, action: #selector(likeToggle), for: .touchUpInside)
        }else{
            let movie = movieInfo.searchResults[indexPath.row]
            cell.likeButton.tag = indexPath.row
            cell.setCell(row: movie)
            cell.likeButton.addTarget(self, action: #selector(likeToggle), for: .touchUpInside)
        }
        return cell
    }
    
    //Todo search 결과에서 눌렀을때 인덱스 오류로 인해 다른 화면으로 넘어감
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.movie = movieInfo.movies[indexPath.row]
        vc.transitionStyle = .push
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @objc func likeToggle(_ sender: UIButton){
        movieInfo.movies[sender.tag].isLiked.toggle()
    }
    
    func setSearchBar(){
        searchBar.placeholder = searchPlaceHolder
        searchBar.showsCancelButton = true
    }
    
    func setLayout(){
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

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.resignFirstResponder()
        view.endEditing(true)
        search()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func search(){
        movieInfo.searchResults.removeAll()
        for item in movieInfo.movies{
            if item.title.contains(searchBar.text!){
                movieInfo.searchResults.append(item)
            }
        }
        collectionView.reloadData()
    }
    
}
