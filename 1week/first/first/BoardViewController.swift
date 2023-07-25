//
//  BoardViewController.swift
//  first
//
//  Created by Alex Cho on 2023/07/19.
//

import UIKit
@available(iOS 13.0, *)
class BoardViewController: UIViewController {
    
    @IBOutlet var textFieldView: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var labelCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designResultLabel()
        designTextField()
        
        for item in labelCollection{
            item.textColor = .red
        }
    }
    
    @IBAction func enterButtonClicked(_ sender: UIButton) {
        resultLabel.text = textFieldView.text
        textFieldView.text = ""
        view.endEditing(true)
        
    }
    @IBAction func outerAreaClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
    func designResultLabel(){
        resultLabel.textAlignment = .center
        resultLabel.text = "Initial Text"
        resultLabel.font = .boldSystemFont(ofSize: 128)
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .systemIndigo

    }
    
    func designTextField(){
        textFieldView.placeholder = "Enter a text"
        textFieldView.borderStyle = .line
    }
 
    
}
