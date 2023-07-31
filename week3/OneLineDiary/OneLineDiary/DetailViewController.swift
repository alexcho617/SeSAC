//
//  DetailViewController.swift
//  OneLineDiary
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var DeleteButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()

    }
    
    @IBAction func deleteButtonClicked(_ sender: UIBarButtonItem) {
        //        push - pop
        navigationController?.popViewController(animated: true)
    }
}
