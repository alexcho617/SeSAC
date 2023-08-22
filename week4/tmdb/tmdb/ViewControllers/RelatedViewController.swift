//
//  RelatedViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/20.
//

import UIKit

class RelatedViewController: UIViewController {
    //클래스 안에서만 사용
    enum DisplayCase{
        case similar
        case recommend
    }
    var mediaId: Int?
    private var similars: Similars?
    private var recommendations: Recommendation?
    private var currentlyDisplaying = DisplayCase.similar
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var relatedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let mediaId{
            callGroupRequest(of: mediaId)
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0: currentlyDisplaying = .similar
            case 1: currentlyDisplaying = .recommend
            default: currentlyDisplaying = .similar
        }
        relatedCollectionView.reloadData()
        
        //스크롤
        if similars?.results != nil && recommendations?.results != nil{
            relatedCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
    
    //네트워크 함수: 실패시 Alert 처리 필요
    private func callGroupRequest(of media: Int){
        let group = DispatchGroup()
        
        group.enter()
        TmdbAPIManager.shared.callRecommendRequest(of: media) { response in
            self.recommendations = response.value ?? Recommendation(page: 1, results: [], totalPages: 1, totalResults: 1)
            if let err = response.error{ print(#function, err, "ALERT")}
            group.leave()
        }
        
        group.enter()
        TmdbAPIManager.shared.callSimilarRequest(of: media) { response in
            self.similars = response.value ?? Similars(page: 1, results: [], totalPages: 1, totalResults: 1)
            if let err = response.error{ print(#function, err,"ALERT")}
            group.leave()
        }
        
        group.notify(queue: .main){
            self.relatedCollectionView.reloadData()
        }
    }

    private func configureView(){
        title = "연관 컨텐츠"
        relatedCollectionView.delegate = self
        relatedCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 180)
        relatedCollectionView.collectionViewLayout = layout
    }
}

extension RelatedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentlyDisplaying {
        case .recommend:
            return recommendations?.results.count ?? 0
        case .similar:
            return similars?.results.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedCollectionViewCell.identifier, for: indexPath) as! RelatedCollectionViewCell
        
        cell.posterImage.contentMode = .scaleAspectFill
        
        switch currentlyDisplaying{
        case .recommend:
            if let item = recommendations?.results[indexPath.item]{
                cell.posterImage.kf.setImage(with: URL.getEndPointImageURL(item.posterPath ?? ""))
                cell.titleLabel.text = item.title
            }
            
        case .similar:
            if let item = similars?.results[indexPath.item]{
                cell.posterImage.kf.setImage(with: URL.getEndPointImageURL(item.posterPath ?? ""))
                cell.titleLabel.text = item.title
            }
        }
        
        return cell
    }
}
