//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by Alex Cho on 2023/08/16.
//

import UIKit

class PosterViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "PosterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PosterCollectionViewCell")
        collectionView.register(UINib(nibName: "HeaderPosterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderPosterCollectionReusableView")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        collectionView.collectionViewLayout = layout
    }

}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as? PosterCollectionViewCell else {return UICollectionViewCell()}
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderPosterCollectionReusableView", for: indexPath) as? HeaderPosterCollectionReusableView else {return UICollectionReusableView()}
        
        view.titleLabel.text = "Placeholder"
        
        return view
    }
    
    
}
