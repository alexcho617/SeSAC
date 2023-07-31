//
//  SearchCollectionViewController.swift
//  OneLineDiary
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        setCollectionViewLayout()

    }
    
    //1 셀 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.backgroundColor = .brown
        cell.ContentsLabel.text = indexPath.description
        
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
