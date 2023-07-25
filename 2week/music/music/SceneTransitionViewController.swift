//
//  SceneTransitionViewController.swift
//  music
//
//  Created by Alex Cho on 2023/07/24.
//

import UIKit
import Kingfisher

class SceneTransitionViewController: UIViewController {
    let iuURL = "https://rare-gallery.com/thumbs/346369-IU-Lee-Ji-Eun-Beautiful-Girls.jpg"
    let newJeansURL = "https://w0.peakpx.com/wallpaper/827/366/HD-wallpaper-newjeans.jpg"
    let placeHolderImage = UIImage(systemName: "person")

    //MARK: Outlets
    @IBOutlet var sigmentedControl: UISegmentedControl!
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    //MARK: Actions
    @IBAction func unwindTohome(_ unwindSegue: UIStoryboardSegue){
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            let url = URL(string: iuURL)
            imageView.kf.setImage(with: url, placeholder: placeHolderImage)
        case 1:
            let url = URL(string: newJeansURL)
            imageView.kf.setImage(with: url, placeholder: placeHolderImage)
        default:
            let url = URL(string: iuURL)
            imageView.kf.setImage(with: url, placeholder: placeHolderImage)
        }
    }
    
}
