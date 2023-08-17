//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by Alex Cho on 2023/08/16.
//

import UIKit
import Alamofire
import Kingfisher
class PosterViewController: UIViewController {
    var list: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    var anotherList: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        LottoManager.shared.callLotto { numOne, numTwo in
        //            print(numOne, numTwo)
        //        }
        //
        configureCollectionView()
        configureCollectionViewLayout()
//    https://www.themoviedb.org/movie/
//    https://www.themoviedb.org/movie/-elemental
//    https://www.themoviedb.org/movie/872585-oppenheimer
//    https://www.themoviedb.org/movie/315162-puss-in-boots-the-last-wish
//    https://www.themoviedb.org/tv/1419-castle
        
        callRecommendation(movieId: 872585) { data in
            self.list = data
            
            self.callRecommendation(movieId: 315162) { data in
                self.anotherList = data
                self.collectionView.reloadData()
            }
            
        }
    }
    
    func callRecommendation(movieId: Int, completionHandler: @escaping (Recommendation) -> Void){
        
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/recommendations?api_key=42de580fd67c2991513fc60dfa628a99&language=ko-KR"
        AF.request(url).validate(statusCode: 200...500).responseDecodable(of:Recommendation.self) { response in
            
            switch response.result{
            case.success(let value):
                
                completionHandler(value)
            case.failure(let error):
                print(error)
            }
        }

    }
  
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        showAlert(title: "Test", message: "Testing...", buttonTitle: "Change") {
//            print("showed alert")
//            self.view.backgroundColor = .systemMint
//        }
//    }
    
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return list.results.count
        case 1:
            return anotherList.results.count
        default:
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {return UICollectionViewCell()}
        
        
        switch indexPath.section {
        case 0:
            let imgUrl = "https://www.themoviedb.org/t/p/w500" + (list.results[indexPath.item].posterPath ?? "")
            let title = list.results[indexPath.item].title
            print(title,imgUrl)
            cell.posterImageView.kf.setImage(with: URL(string: imgUrl))
            
        case 1:
            let imgUrl = "https://www.themoviedb.org/t/p/w500" + (anotherList.results[indexPath.item].posterPath ?? "")
            let title = anotherList.results[indexPath.item].title
            print(title,imgUrl)
            cell.posterImageView.kf.setImage(with: URL(string: imgUrl))
            
        default:
            print("other section")
        }
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else {return UICollectionReusableView()}
        
        view.titleLabel.text = "Placeholder"
        
        return view
    }
    
}

extension PosterViewController: CollectionViewAttributeProtocol{
    
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier)
    }
    
    func configureCollectionViewLayout(){
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        collectionView.collectionViewLayout = layout
    }
}


