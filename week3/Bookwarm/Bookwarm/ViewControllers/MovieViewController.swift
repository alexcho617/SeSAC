//
//  MovieViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/08/02.
//

import UIKit

final class MovieViewController: UIViewController {
    private let movieManager = MovieInfo()
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    @IBOutlet weak var movieTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "둘러보기"

        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        let collectionnib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        movieCollectionView.register(collectionnib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        configureCollectionViewLayout()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        let tablenib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        movieTableView.register(tablenib, forCellReuseIdentifier: "MovieTableViewCell")
        configureTableView()
        
    }
}

///TableView Extension
extension MovieViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //vc
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
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
    
    func configureTableView(){
        movieTableView.separatorInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
}
extension MovieViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieManager.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let row = movieManager.movies[indexPath.row]
        
        cell.titleLabel.text = row.title
        cell.posterImageView.image = UIImage(named: row.title)
        cell.infoLabel.text = "\(row.releaseDate) | \(row.runtime)분"
        return cell
    }
    
    
}

///CollectionView Extension
extension MovieViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //vc
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
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
        movieCollectionView.collectionViewLayout = layout
    }
}

extension MovieViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieManager.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let item = movieManager.movies[indexPath.row]
        cell.posterImageView.image = UIImage(named: item.title)
        return cell
    }
    
}
