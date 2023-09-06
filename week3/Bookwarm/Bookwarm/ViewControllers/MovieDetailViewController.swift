//
//  MovieDetailViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit
enum TransitionStyle{
    case modal,push
}
final class MovieDetailViewController: UIViewController {
    var movie: Movie?
    private var transitionStyle: TransitionStyle = .modal
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    @IBOutlet weak var memoTextView: UITextView!
    private let placeholder = "메모를 입력하세요"

    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.delegate = self
        configureScreen()
    }
    
    private func configureScreen(){
        if transitionStyle == .push{
            closeButton.isHidden = true
        }else if transitionStyle == .modal{
            closeButton.isHidden = false
        }
        
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
        
        memoTextView.backgroundColor = .secondarySystemBackground
       setMemoTextView()

    }

    @IBAction func closeButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func likeButtonClikced(_ sender: UIButton) {
        
        //제대로 구현하려면 movie unique id 같은걸 부여해서 movieInfo 에도 반영되게 해야함
//        movie?.isLiked.toggle()
//        likeButton.setImage(movie?.isLiked == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)

    }
    
}

extension MovieDetailViewController: UITextViewDelegate{

    func setMemoTextView(){
        if movie!.memo == nil{
            memoTextView.text = placeholder
            memoTextView.textColor = .systemGray
        }else{
            memoTextView.text = movie!.memo
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder{
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
        //이것도 Delegate이나 closure 없이는 안됨. 디테일의 좋아요 기능이랑 마찬가지
//        movie?.memo = textView.text
        textView.resignFirstResponder()
        view.endEditing(true)
    }
}
