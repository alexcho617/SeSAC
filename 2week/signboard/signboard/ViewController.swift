//
//  ViewController.swift
//  signboard
//
//  Created by Alex Cho on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    //variables and outlets
    @IBOutlet var textField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var labelView: UILabel!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    @IBOutlet var cycleButton: UIButton!
    var timeTrigger = false
    var realTime = Timer()
    var isColorOnRepeat = false
    
    let colorPool = [UIColor.systemRed,UIColor.systemGreen,UIColor.systemBlue,UIColor.systemYellow, UIColor.systemPink,UIColor.systemMint]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.placeholder = "메시지를 입력하세요!"
        editButton.isHidden = true
        
    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        textField.isHidden = false
        sendButton.isHidden = false
        randomButton.isHidden = false
        cycleButton.isHidden = false
        
        editButton.isHidden = true
        //stop color change
        timeTrigger = true
        realTime.invalidate()
        
       
    }
    
    @IBAction func textFieldEnd(_ sender: Any) {
        textEntered()
    }
    @IBAction func cycleButtonClicked(_ sender: UIButton) {
        isColorOnRepeat = !isColorOnRepeat
        if isColorOnRepeat == true{
            //start
            print("on")
            cycleButton.setImage(UIImage(systemName: "repeat.circle.fill"), for: .normal)
            
            //trigger color change
            timeTrigger = true
            timerAction()
            
        }else{
            //stop
            print("off")
            cycleButton.setImage(UIImage(systemName: "repeat.circle"), for: .normal)
            
            //stop color change
            timeTrigger = true
            realTime.invalidate()
        }
                
        
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        textEntered()
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        let randomColor = colorPool.randomElement()
        labelView.textColor = randomColor
        textField.textColor = randomColor
    }
    
    func textEntered(){
        labelView.text = textField.text
        view.endEditing(true)
        
        //hide buttons
        textField.isHidden = true
        sendButton.isHidden = true
        randomButton.isHidden = true
        cycleButton.isHidden = true
        
        //show edit button
        editButton.isHidden = false
        
      
        
    }
    
    func timerAction(){
        if(timeTrigger){
            checkTimeTrigger()
        }else{
            return
        }
    }
    func checkTimeTrigger() {
        realTime = Timer.scheduledTimer(timeInterval: 0.5, target: self,
            selector: #selector(changeColor), userInfo: nil, repeats: true)
    }
    @objc func changeColor(){
        print("change color")
        let randomColor = colorPool.randomElement()
        labelView.textColor = randomColor
    }
    
}

