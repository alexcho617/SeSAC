//
//  BookCollectionViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit

class BookCollectionViewController: UICollectionViewController {
    let formatter = NumberFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Shelf"
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        formatter.maximumFractionDigits = 1
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
        let row = MovieInfo.movies[indexPath.row]
        cell.backgroundColor = UIColor(cgColor: .init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: CGFloat.random(in: 0...1)))
        cell.cellLabel?.text = row.title
        let fs = formatter.string(for: row.rate)
        cell.cellRatingLabel?.text = fs
        
        let image = UIImage(named: row.title) ?? UIImage(systemName: "picture")
        cell.cellImageView.image = image
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.titleFromParent = MovieInfo.movies[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
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
