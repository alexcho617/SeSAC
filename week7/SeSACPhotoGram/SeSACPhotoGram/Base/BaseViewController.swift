//
//  BaseViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/28.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Base VDL")
        configureView()
        setConstraints()
    }
    
    func configureView(){
        print("Base configure")
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        print("Base setConstraints")
    }

}
