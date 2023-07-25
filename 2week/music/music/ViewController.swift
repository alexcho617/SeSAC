//
//  ViewController.swift
//  music
//
//  Created by Alex Cho on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var firstImage: UIImageView!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var firstButton: UIButton!
    
    //editable끄고 data detector 키면 시스템과 자동 연동
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func superViewClicked(_ sender: UITapGestureRecognizer) {
        firstImage.isHidden.toggle()
    }
    
    @IBAction func firstButtonClicked(_ sender: UIButton) {
        
    }
    
}

