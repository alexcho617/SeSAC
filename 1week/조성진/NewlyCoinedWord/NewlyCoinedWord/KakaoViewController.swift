//
//  AutoLayoutPracticeViewController.swift
//  NewlyCoinedWord
//
//  Created by Alex Cho on 2023/07/21.
//

import UIKit

class KakaoViewController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileImage()
    }
    
    //functions
    func setProfileImage(){
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 15
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.white.cgColor
    }
}
