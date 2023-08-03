//
//  DetailViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    var movie: Movie?
    //Todo: Folder divide
    //Todo: Enum사용해서 closeButton 보이거나 숨기기
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    func configureScreen(){
        guard let movie else {return}
        title = movie.title
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        let fs: String = formatter.string(for: movie.rate)!
        ratingLabel.text = fs + "점"
        
        backgroundImageView.image = UIImage(named: movie.title)
        
        infoLabel.text = "\(movie.releaseDate) | \(movie.runtime)분"
        overviewTextView.text = movie.overview
        overviewTextView.isEditable = false
        overviewTextView.backgroundColor = .secondarySystemBackground
        likeButton.setImage(movie.isLiked == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        

    }

    @IBAction func closeButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func likeButtonClikced(_ sender: UIButton) {
        
        //제대로 구현하려면 unique id 같은걸 부여해서 movieInfo 에도 반영되게 해야함
//        movie?.isLiked.toggle()
//        likeButton.setImage(movie?.isLiked == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)

    }
    
}
