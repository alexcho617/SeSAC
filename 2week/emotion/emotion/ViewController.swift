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
        case veryhappy =  "emoji0"
        case happy =  "emoji1"
        case soso =  "emoji2"
        case sad =  "emoji3"
        case verysad =  "emoji4"
    }
    //Variables
    
    
    let emojis = Emotion.allCases
    //Outlets
    @IBOutlet var pullDownCollection: [UIButton]!
    
    //vdl
    override func viewDidLoad() {
        super.viewDidLoad()
        setEmojiButtons()
        
    }
    
    
    //Actions
    @IBAction func emojiButtonAction(_ sender: UIButton) {
        let selectedEmotion = emojis[sender.tag].rawValue
        print(selectedEmotion)
        if ViewController.counterManager.isValid(forKey: selectedEmotion){
            ViewController.counterManager.increment(selectedEmotion, by: 1)
        } else{
            fatalError("key does not exist")
        }
    }
    
    @IBAction func pullDownClicked(_ sender: UIButton) {
        sender.showsMenuAsPrimaryAction.toggle()
        
    }
    
    //Functions
    func setEmojiButtons(){
        for i in 0..<emojis.count{
            let one = UIAction(title: "+1", handler: {_ in
                ViewController.counterManager.increment("emoji"+String(i), by: 1)
                ViewController.counterManager.printCounterStatus()
            })
            let five = UIAction(title: "+5", handler: { _ in
                ViewController.counterManager.increment("emoji"+String(i), by: 5)
                ViewController.counterManager.printCounterStatus()
            })
            let ten = UIAction(title: "+10", handler: { _ in             ViewController.counterManager.increment("emoji"+String(i), by: 10)
                ViewController.counterManager.printCounterStatus()
            })
            
            let buttonMenu = UIMenu(title: "감정 더하기", children: [one, five, ten])
            pullDownCollection[i].menu = buttonMenu
            pullDownCollection[i].setImage(UIImage(named: emojis[i].rawValue), for: .normal)
            
            //            emojiButtonOutletCollection[i].tag = i
            
        }
    }
}

