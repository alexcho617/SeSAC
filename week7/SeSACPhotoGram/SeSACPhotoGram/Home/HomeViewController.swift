//
//  HomeViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/31.
//

import UIKit

class HomeViewController: BaseViewController {
    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    let mainView = HomeView()
    override func loadView() { //super method 호출 X: Apple의 UIView로 덮힐 수 있음
        mainView.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        callRequest()
        
        
    }
    
    
    func callRequest(){
        print(#function)
        APIService.shared.callRequestWithURLSession(query: "sky") { photos in
            guard let photos = photos else{
                print("ALERT ERROR")
                return
            }
            self.list = photos
            print(self.list)
            
            self.mainView.collectionView.reloadData()
        }
    }
    //delegate를 연결하니 deinit이 안되고이씀
    deinit {
        print(#function, self)
    }
    
}

extension HomeViewController: HomeViewProtocol{
    func didSelectItemAt(indexPath: IndexPath) {
        
        navigationController?.popViewController(animated: false)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(#function, #line)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        print(#function)
        let item = list.results[indexPath.item].urls.thumb
        let url = URL(string: item) // 이 부분 네트워크 통신임
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url!)//동기코드
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        //어떠한 navigation 불가: View Controller가 담당하고 있기 때문
        //delegate pattern을 사용한 값 전달
//        delegate?.didSelectItemAt(indexPath: indexPath)
    }
    
    
}
