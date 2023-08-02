//
//  BookCollectionViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit

class BookCollectionViewController: UICollectionViewController {
    var movieInfo = MovieInfo(){
        didSet{
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Shelf"
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        setLayout()
    }
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MovieInfo.movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else{
            print("failed to build cell")
            return UICollectionViewCell()
        }
        //configure cell
        let movie = MovieInfo.movies[indexPath.row]
//        cell.tag = indexPath.row 버튼이 아니라 셀 자체 태그를 지정해서 안됐었다..
        cell.likeButton.tag = indexPath.row
        
        print("cell tag:",cell.tag)
        //set cell
        cell.setCell(row: movie)
       
        cell.likeButton.addTarget(self, action: #selector(likeToggle), for: .touchUpInside)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.titleFromParent = MovieInfo.movies[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
        
        print("selected at indexPath.row:",indexPath.row)
    }
    
    //issue: sender.tag로 구분 할 수가 없는 상태임
    //현재 출력하면 태그가 모두 0으로 출력되고 있음
    @objc func likeToggle(_ sender: UIButton){
        print("liked button pressed at tag \(sender.tag)")
        MovieInfo.movies[sender.tag].isLiked.toggle()
        
        collectionView.reloadData()

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
