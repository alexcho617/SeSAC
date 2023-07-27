//
//  ViewController.swift
//  emotion
//
//  Created by Alex Cho on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    enum Emotion: String, CaseIterable{
        case veryhappy =  "emoji0"
        case happy =  "emoji1"
        case soso =  "emoji2"
        case sad =  "emoji3"
        case verysad =  "emoji4"
    }
    
    //Variables
    public static var counterManager = CounterManager()
    var emojis = Emotion.allCases

    var a = 0 {
        didSet {
            
        }
    }
    
    //Outlets
    @IBOutlet var pullDownCollection: [UIButton]!
    
    //vdl
    override func viewDidLoad() {
        super.viewDidLoad()
        setEmojiButtons()
    }
    
    //Actions
    @IBAction func pullDownClicked(_ sender: UIButton) {
        sender.showsMenuAsPrimaryAction.toggle()
    }
    
    //Functions
    func setEmojiButtons(){
        for i in 0..<emojis.count{
            let one = UIAction(title: "+1", handler: {_ in
                ViewController.counterManager.increment("emoji"+String(i), by: 1)
            })
            let five = UIAction(title: "+5", handler: { _ in
                ViewController.counterManager.increment("emoji"+String(i), by: 5)
            })
            let ten = UIAction(title: "+10", handler: { _ in
                ViewController.counterManager.increment("emoji"+String(i), by: 10)
            })
            let pullDownMenu = UIMenu(title: "감정 더하기", children: [one, five, ten])
            pullDownCollection[i].menu = pullDownMenu
            pullDownCollection[i].setImage(UIImage(named: emojis[i].rawValue), for: .normal)
        }
    }
}

