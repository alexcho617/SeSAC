//
//  ViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.placeholder = "nickname_placeholder".localized
        let name = "Alex"
//        let value = NSLocalizedString("nickname_result", comment: "")
//        label.text = String(format: value, name)
        label.text = "age_result".localized(number: 12)
        
        //cmd ctrl e: refactor 유사
        let searchBar = UISearchBar()
        searchBar.text = "asdf"
        searchBar.placeholder = "asdasd"
    }
    
    //ctrl shift click
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }

}

