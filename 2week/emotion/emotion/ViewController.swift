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
    @IBOutlet var emojiButtonOutletCollection: [UIButton]!
    
    
    
    @IBOutlet var dropDownButton: UIButton!
    //vdl
    override func viewDidLoad() {
        super.viewDidLoad()
        setEmojiButtons()
//
//        let one = UIAction(title: "+1", handler: { _ in print("+1") })
//        let five = UIAction(title: "+5", handler: { _ in print("+5") })
//        let ten = UIAction(title: "+10", handler: { _ in print("+10") })
//
//        let buttonMenu = UIMenu(title: "메뉴 타이틀", children: [one, five, ten])
//        dropDownButton.menu = buttonMenu
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
        ViewController.counterManager.printCounterStatus()
                
    }
    
    @IBAction func dropDownButtonClicked(_ sender: UIButton) {
        dropDownButton.showsMenuAsPrimaryAction.toggle()
    }
    //Functions
    func setEmojiButtons(){
        print(emojis)

        for i in 0..<emojis.count{
            print(i,emojis[i].rawValue)
            emojiButtonOutletCollection[i].setImage(UIImage(named: emojis[i].rawValue), for: .normal)
            
//            emojiButtonOutletCollection[i].tag = i
          
        }
    }
}

