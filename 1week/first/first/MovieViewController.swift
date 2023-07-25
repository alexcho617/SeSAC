//
//  MovieViewController.swift
//  first
//
//  Created by Alex Cho on 2023/07/19.
//

import UIKit
@available(iOS 13.0, *)
class MovieViewController: UIViewController {
    
    var nickName: String = "alex"
    var movieNames = ["부산행", "베테랑", "명량", "도둑들","극한직업","신과함께인과연","신과함께죄와벌","아바타","알라딘","암살"]
    @IBOutlet var mainPosterView: UIImageView!
    @IBOutlet var firstPreview: UIImageView!
    @IBOutlet var secondPreview: UIImageView!
    @IBOutlet var thirdPreview: UIImageView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    
    /*
     ViewController Life Cycle: excuted just before screen appears to the user.
     Used to set properties that cannot be set on the storyboard's property inspector.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setMovieScene()
    }
    

    @IBAction func playButtonClicked(_ sender: UIButton) {
        changeMainPoster()
        changePreviewPoster()
    }
    
    @IBAction func moviesButtonClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let buttonDelete = UIAlertAction(title: "Delete", style: .destructive)
        let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel)
        let button1 = UIAlertAction(title: "1", style: .default)
        let button2 = UIAlertAction(title: "2", style: .default)
        
        alert.addAction(buttonCancel)
        alert.addAction(button1)
        alert.addAction(button2)
        alert.addAction(buttonDelete)
        
        
        present(alert, animated: true)
    }
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        //1 contents
        let alert = UIAlertController(title: "제목이야", message: "이건 메세지야", preferredStyle: .alert)
        //2 cancel & ok
        let alertCancelAction = UIAlertAction(title: "취소", style: .cancel)
        let alertOkAction = UIAlertAction(title: "좋아", style: .default)
        //3 combine
        alert.addAction(alertCancelAction)
        alert.addAction(alertOkAction)
        //4 alert present
        present(alert, animated: true)
    }
    
    func setMovieScene(){
        changeMainPoster()
        setPreviewImage(imagePreview: firstPreview, imageIndex: 0)
        setPreviewImage(imagePreview: secondPreview, imageIndex: 1)
        setPreviewImage(imagePreview: thirdPreview, imageIndex: 2)
        setPlayButton()
    }
    
    func changeMainPoster(){
        mainPosterView.image = UIImage(named: String(Int.random(in: 1...5)))
    }
    
    func changePreviewPoster(){
        movieNames.shuffle()
        firstPreview.image = UIImage(named: movieNames[0] )
        secondPreview.image = UIImage(named: movieNames[1] )
        thirdPreview.image = UIImage(named: movieNames[2] )
    }
    
    /*
     Argument Label = external parameter = imagePreview
     Parameter Name = internal parameter = preview
     */
    @available(iOS 13.0, *)
    func setPreviewImage(imagePreview preview: UIImageView, imageIndex index: Int){
        preview.image = UIImage(named: movieNames[index])
        preview.layer.borderColor = UIColor.systemGray6.cgColor
        preview.layer.cornerRadius = 50
        preview.layer.borderWidth = 3
        preview.contentMode = .scaleAspectFill
    }
    func setPlayButton(){
        playButton.setImage(UIImage(named: "play_normal"), for: .normal)
        playButton.setImage(UIImage(named: "play_highlighted"), for: .highlighted)
    }
    

}
