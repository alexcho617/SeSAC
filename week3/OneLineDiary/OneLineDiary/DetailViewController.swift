//
//  DetailViewController.swift
//  OneLineDiary
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    //stored property로 선언해서 initiazlier를 사용하지 않았음
    var contents: String = "empty space"
  
    
    @IBOutlet weak var contentsLabel: UILabel!
    
    
    @IBOutlet weak var DeleteButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        print(contents)
        title = contents
        contentsLabel.text = contents

    }
    
    @IBAction func deleteButtonClicked(_ sender: UIBarButtonItem) {
        //        push - pop
        navigationController?.popViewController(animated: true)
    }
}
