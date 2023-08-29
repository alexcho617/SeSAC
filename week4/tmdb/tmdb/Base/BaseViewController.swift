//
//  BaseViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setConstraints()
    }
    func setView(){ view.backgroundColor = .systemBackground}
    func setConstraints(){}
    


}
