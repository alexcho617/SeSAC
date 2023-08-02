//
//  DiscoverViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/08/02.
//

import UIKit

class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let movieManager = MovieInfo()
    
    
    @IBOutlet weak var DiscoverCollectionView: UICollectionView!
    
    @IBOutlet weak var DiscoverTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DiscoverCollectionView.delegate = self
        DiscoverCollectionView.dataSource = self
        let collectionnib = UINib(nibName: "DiscoverCollectionViewCell", bundle: nil)
        DiscoverCollectionView.register(collectionnib, forCellWithReuseIdentifier: "DiscoverCollectionViewCell")
        configureCollectionViewLayout()
        
        
        DiscoverTableView.delegate = self
        DiscoverTableView.dataSource = self
        let tablenib = UINib(nibName: "DiscoverTableViewCell", bundle: nil)
        DiscoverTableView.register(tablenib, forCellReuseIdentifier: "DiscoverTableViewCell")
        
        title = "둘러보기"
        
    }
    /// collection view
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieManager.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCollectionViewCell", for: indexPath) as! DiscoverCollectionViewCell
        let item = movieManager.movies[indexPath.row]
        cell.posterImageView.image = UIImage(named: item.title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //vc
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.movie = movieManager.movies[indexPath.row]
        
        let nc = UINavigationController(rootViewController: vc)
        
        //set
        nc.modalPresentationStyle = .fullScreen
        //navigate
        present(nc, animated: true)
    }
    
    func configureCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        //        layout.itemSize = CGSize(width: 100,height: 100)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.25,height: UIScreen.main.bounds.height * 0.17)
        layout.scrollDirection = .horizontal
        DiscoverCollectionView.collectionViewLayout = layout
        
    }
    
    /// tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieManager.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverTableViewCell", for: indexPath) as! DiscoverTableViewCell
        let row = movieManager.movies[indexPath.row]
        
        cell.titleLabel.text = row.title
        cell.posterImageView.image = UIImage(named: row.title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //vc
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.movie = movieManager.movies[indexPath.row]
        
        let nc = UINavigationController(rootViewController: vc)
        
        //set
        nc.modalPresentationStyle = .fullScreen
        //navigate
        present(nc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        190
    }
    
}
