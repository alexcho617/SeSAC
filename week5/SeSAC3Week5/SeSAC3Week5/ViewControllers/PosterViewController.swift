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
    var listOne: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    var listTwo: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    var listThree: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    var listFour: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCollectionViewLayout()
//        dispatchGroupEnterLeave()
        dispatchGroupEnterLeaveLoop()

      
    }
    
    
    
    //foreground에서 알림이 안뜨는게 디폴트 앱이 백그라운드에서만 알림이 뜸
    
    
    @IBAction func sendNotification(_ sender: UIButton) {
        //1 contents
        let content = UNMutableNotificationContent()
        content.title = "Water Tama"
        content.body =  "Its THIRSTY Give \(Int.random(in: 1...100))"
        content.badge = 100
        
        //2 when: time trigger, calendar trigger
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        var component = DateComponents()
        component.minute = 5
        component.hour = 10
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
        
        //3 id가 다르면 새로운 알림, 같으면 내용만 다른 하나의 알림
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        
            
        //deep linking은 어떻게?
        }
    }
    
    
    
    func dispatchGroupEnterLeaveLoop(){
        let group = DispatchGroup()
        let ids = [671,672,673,674]
        for id in ids{
            group.enter()
            callRecommendation(movieId: id) { data in
                //logic
                //2d array or conditional
                group.leave()
            }
        }
        group.notify(queue: .main){
            print("done")
            self.collectionView.reloadData()
        }
    }
    
    
    //MARK: Use Enter/Leave reference counting to notify main thread. Used for grouping async tasks
    func dispatchGroupEnterLeave(){
        let group = DispatchGroup()
        group.enter() // +1 group reference count
        self.callRecommendation(movieId: 671) { data in
            self.listOne = data
            print(#line)
            group.leave() // -1 group reference count
        }
        
        group.enter()
        self.callRecommendation(movieId: 672) { data in
            self.listTwo = data
            print(#line)
            group.leave()
        }
        
        group.enter()
        self.callRecommendation(movieId: 673) { data in
            self.listThree = data
            print(#line)
            group.leave()
        }
        
        group.enter()
        self.callRecommendation(movieId: 674) { data in
            self.listFour = data
            print(#line)
            group.leave()
        }
        group.notify(queue: .main){
            self.collectionView.reloadData()
            print("Done")
        }
    }
    
    //MARK: Use only notify to main thread. Used for grouping sync tasks
    func dispatchGroupNotify(){
        let group = DispatchGroup()
        /*
         비동기 내에 비동기가 있음.
         따라서 동기 코드를 비동기에 묵는것과 비동기 코드를 비동기로 묵는것은 차이가 있음.
         그래서 네트워크 코드를 비동기로 묶으면 올바르게 작동이 안됨
         */
        DispatchQueue.global(qos: .userInitiated).async(group: group){
            self.callRecommendation(movieId: 671) { data in
                self.listOne = data
                print(#line)
            }
        }
        DispatchQueue.global().async(group: group){
            self.callRecommendation(movieId: 672) { data in
                self.listTwo = data
                print(#line)
            }
        }
        DispatchQueue.global().async(group: group){
            self.callRecommendation(movieId: 673) { data in
                self.listThree = data
                print(#line)
            }
        }
        DispatchQueue.global().async(group: group){
            self.callRecommendation(movieId: 674) { data in
                self.listFour = data
                print(#line)
            }
        }
        group.notify(queue: .main){
            print("Done")
            self.collectionView.reloadData()
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
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return listOne.results.count
        case 1:
            return listTwo.results.count
        case 2:
            return listThree.results.count
        case 3:
            return listFour.results.count
        default:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {return UICollectionViewCell()}
        
        
        switch indexPath.section {
        case 0:
            let imgUrl = "https://www.themoviedb.org/t/p/w500" + (listOne.results[indexPath.item].posterPath ?? "")
            cell.posterImageView.kf.setImage(with: URL(string: imgUrl))
            
        case 1:
            let imgUrl = "https://www.themoviedb.org/t/p/w500" + (listTwo.results[indexPath.item].posterPath ?? "")
            cell.posterImageView.kf.setImage(with: URL(string: imgUrl))
            
        case 2:
            let imgUrl = "https://www.themoviedb.org/t/p/w500" + (listThree.results[indexPath.item].posterPath ?? "")
            cell.posterImageView.kf.setImage(with: URL(string: imgUrl))
            
        case 3:
            let imgUrl = "https://www.themoviedb.org/t/p/w500" + (listFour.results[indexPath.item].posterPath ?? "")
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
        view.titleLabel.font = UIFont(name: "Ramche", size: 20)
        
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



//
//for item in UIFont.familyNames{
//    print(item)
//    for name in UIFont.fontNames(forFamilyName: item){
//        print("==",name)
//    }
//}



//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        showAlert(title: "Test", message: "Testing...", buttonTitle: "Change") {
//            print("showed alert")
//            self.view.backgroundColor = .systemMint
//        }
//    }




//Callback hell
//        callRecommendation(movieId: 872585) { data in
//            self.listOne = data
//            self.callRecommendation(movieId: 315162) { data in
//                self.listTwo = data
//                self.callRecommendation(movieId: 157336) { data in
//                    self.listThree = data
//                    self.callRecommendation(movieId: 479718) { data in
//                        self.listFour = data
//                        self.collectionView.reloadData()
//                    }
//                }
//            }
//        }

//reloading 4times
//        callRecommendation(movieId: 872585) { data in
//            self.listOne = data
//            self.collectionView.reloadData()
//        }
//        callRecommendation(movieId: 315162) { data in
//            self.listTwo = data
//            self.collectionView.reloadData()
//        }
//        callRecommendation(movieId: 157336) { data in
//            self.listThree = data
//            self.collectionView.reloadData()
//        }
//        callRecommendation(movieId: 479718) { data in
//            self.listFour = data
//            self.collectionView.reloadData()
//        }
