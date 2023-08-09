//
//  SearchViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit
/*
 현재 사용 안함
 */
class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
    }
    
    @objc
    func closeButtonClicked(){
        dismiss(animated: true)
    }


}
