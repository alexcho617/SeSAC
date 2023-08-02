//
//  TimelineViewController.swift
//  OneLineDiary
//
//  Created by Alex Cho on 2023/08/02.
//

import UIKit

/*
 1.protocol: UICollectionViewDelegate, UICollectionViewDataSource
 2.connect collectionview and protocol: delegate = self (타입으로서의 프로토콜 사용)
 3.connect collectionview and outlet
 */

class TimelineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var todayCollectionView: UICollectionView!
    
    @IBOutlet weak var bestCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //3.
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        bestCollectionView.delegate = self
        bestCollectionView.dataSource = self
        //xib register for cell
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        todayCollectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        bestCollectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        
        configureCellLayout()
        bestCollectionViewLayout()
        
        
        

    }
    
    func configureCellLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 180)
        
//        왼쪽만 패딩을 주고 오른쪽은 안줘서 내용이 더 있는걸 알린다
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        todayCollectionView.collectionViewLayout = layout
//        bestCollectionView.collectionViewLayout = layout

    }
    func bestCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 180)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0 //이건 뭐지??

        bestCollectionView.isPagingEnabled = true //device width 기준으로각 셀들을 스내핑 하는 효과

        bestCollectionView.collectionViewLayout = layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return collectionView == todayCollectionView ? 3: 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        if collectionView == todayCollectionView{
            cell.ContentsLabel.text = "today:" + indexPath.item.description
            cell.backgroundColor = .yellow
        }else{
            cell.ContentsLabel.text = indexPath.item.description
            cell.backgroundColor = [.gray, .yellow, .red, .orange, .green, .blue,.systemMint].randomElement()
        }
        
        
        return cell
    }
    
}
