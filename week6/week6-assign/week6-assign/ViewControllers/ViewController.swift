//
//  ViewController.swift
//  week6-assign
//
//  Created by Alex Cho on 2023/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.pushViewController(LoginViewController(), animated: true)

    }

    @IBAction func onePressed(_ sender: UIButton) {
        navigationController?.pushViewController(OneViewController(), animated: true)
    }
    @IBAction func twoPressed(_ sender: UIButton) {
        navigationController?.pushViewController(TwoViewController(), animated: true)
    }
    
    @IBAction func threePressed(_ sender: UIButton) {
        navigationController?.pushViewController(ThreeViewController(), animated: true)
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        navigationController?.pushViewController(LocationViewController(), animated: true)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        navigationController?.pushViewController(LoginViewController(), animated: true)

    }
    
    @IBAction func netflixPressed(_ sender: UIButton) {
    }
    
}

