//
//  ViewController.swift
//  emotion
//
//  Created by Alex Cho on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    public static var counterManager = CounterManager()
    
    enum Emotion: String, CaseIterable{
        case veryhappy =  "emoji1"
        case happy =  "emoji2"
        case soso =  "emoji3"
        case sad =  "emoji4"
        case verysad =  "emoji5"
    }
    //Variables
  
    
    let emojis = Emotion.allCases
   
    //Outlets
    @IBOutlet var emojiButtonOutletCollection: [UIButton]!
    
    //vdl
    override func viewDidLoad() {
        super.viewDidLoad()
        setEmojiButtons()
    }
    
    
    //Actions
    
    @IBAction func emojiButtonAction(_ sender: UIButton) {
        //update dict
        let selectedEmotion = emojis[sender.tag]
//        print(selectedEmotion)
        if ViewController.counterManager.counterDict[selectedEmotion.rawValue] != nil{
            ViewController.counterManager.counterDict[selectedEmotion.rawValue]! += 1
        } else{
            fatalError("key does not exist")
        }
        print(ViewController.counterManager.counterDict)
                
    }
    
    //Functions
    func setEmojiButtons(){
        for i in 0..<emojis.count{
            emojiButtonOutletCollection[i].setImage(UIImage(named: emojis[i].rawValue), for: .normal)
            emojiButtonOutletCollection[i].tag = i
          
        }
    }
}

