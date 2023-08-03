//
//  SearchCollectionViewController.swift
//  OneLineDiary
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController {
    let searchBar = UISearchBar()
    let list = [
        "iOS","iPad","Android","iPhone","Watch","Apple","Google","사장","사과"
    ]
    var result: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        //이미 navigation에들어있기 때문에 가능함
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        setCollectionViewLayout()
        
    }
    
    //1 셀 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if result.isEmpty{
            return list.count
        }else{
        }
        return result.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.backgroundColor = .brown
        if result.isEmpty{
            cell.ContentsLabel.text = list[indexPath.row]
        }else{
            cell.ContentsLabel.text = result[indexPath.row]
        }
        return cell
    }
    
    func setCollectionViewLayout(){
        //cell estimatd size none  으로 IB설정할것
        let layout = UICollectionViewFlowLayout()
        
        //**device width
        //        item width = device.width - 2*inset padding - numberOfItemsPerRow - 1 * itemPadding / numberofItems
        let itemSpacing: CGFloat = 20
        let itemWidth = UIScreen.main.bounds.width - (itemSpacing * 4) //4 because 2(leading trailing padding)+2(itempadding)
        
        layout.itemSize = CGSize(width: itemWidth/3, height: itemWidth/3)
        //scroll이펙은 주지만 패딩을 준다.여백을 주는것과는 시각적으로 차이가 많이 난다. 강제로 여백을 주면 컨텐츠가 짤리기 떄문이다.
        layout.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)//set inset for entire collectionview
        
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        collectionView.collectionViewLayout = layout
    }
    
}

//이런식으로 따로 뺴낸다
extension SearchCollectionViewController: UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(#function)
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        //clear previous result
        result.removeAll()
        for item in list{
            if item.contains(searchBar.text!){
                result.append(item)
            }
        }
        //collectionview must switch data
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.resignFirstResponder()
        result.removeAll()
        searchBar.text = ""
        collectionView.reloadData()
    }
    
    //실시간 검색, 지연 검색은 어떻게 하나? 0.5초 정도 입력 없을시 검색하는거
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //clear previous result
        result.removeAll()
        for item in list{
            if item.contains(searchBar.text!){
                result.append(item)
            }
        }
        //collectionview must switch data
        collectionView.reloadData()
    }
    
}
