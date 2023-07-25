//
//  WordViewController.swift
//  NewlyCoinedWord
//
//  Created by Alex Cho on 2023/07/21.
//

import UIKit

class WordViewController: UIViewController {
    
    enum Fruits: String {
        case apple
        case banana
        case carrot
        case durian
        case eggplant
    }
    
    var wordDict = ["apple":"1.사과, 사과나무 (※사과나무는 apple tree가 보통)","banana":"1.바나나 （나무） ; 그 열매","carrot":"1.〔식물〕 당근; [가][불] 그 뿌리.","durian":"1.두리안: 동남 아시아산 판야과의 식용 과일.","eggplant":"1.〔식물〕 가지."]
    
    //oulets
    @IBOutlet var wordTextField: UITextField!
    
    @IBOutlet var suggestionButtonViewCollection: [UIButton]!
    
    @IBOutlet var resultLabel: UILabel!
    
    //vdl
    override func viewDidLoad() {
        super.viewDidLoad()
        setResultLabel()
        setTextField()
        setSuggestionButtons()
        textFieldEnter(wordTextField)
        
    }
    
    //actions
    @IBAction func textFieldEnter(_ sender: UITextField) {
//        기존 딕셔너리를 사용한 코드
//        let key = wordTextField.text
//        if wordDict[key!] != nil {
//            resultLabel.text = wordDict[key!]
//        }else{
//            resultLabel.text = "No Result"
//        }
        
        //열거형을 사용하긴 했지만 정말로 더 나은 코드인지는 의문이 든다.
        if let selectedFruit = Fruits(rawValue: wordTextField.text ?? "") {
            switch selectedFruit {
            case .apple, .banana, .carrot, .durian, .eggplant:
                let description = wordDict[selectedFruit.rawValue] ?? "No Result"
                resultLabel.text = description
            }
        } else {
            resultLabel.text = "No Result"
        }
    }
    
    @IBAction func suggestionButtonClicked(_ sender: UIButton) {
        wordTextField.text = sender.currentTitle
        textFieldEnter(wordTextField)
    }
    
    //functions
    func setResultLabel(){
        resultLabel.textAlignment = .center
    }
    
    func setTextField(){
        wordTextField.placeholder = "신조어를 입력하세요"
        wordTextField.layer.borderWidth = 1
        wordTextField.layer.borderColor = UIColor.black.cgColor
        wordTextField.text = getRandomWord()
    }
    
    func setSuggestionButtons(){
        //change appearance
        for button in suggestionButtonViewCollection{
            button.tintColor = .black
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
        }
        //random draw
        let numberOfRandomItems = suggestionButtonViewCollection.count
        let keys = Array(wordDict.keys)
        var randomIndices = Set<Int>()
        var randomKeys: [String] = []
        
        //draw random numbers and put into set -> 딕셔너리 셔플을 피하려고 한건데 이렇게 인덱스로 할거였으면 그냥 random element로 뽑아서 셋에다 넣는거랑 별 차이가 없었다. 숫자를 뽑는거나 단어를 뽑는거나 둘 다 비슷하기 때문.
        while randomIndices.count < numberOfRandomItems{
            let numberDrawn = Int.random(in: 0..<numberOfRandomItems)
            randomIndices.insert(numberDrawn)
        }
        
        //put each random key into array
        for randomIndex in randomIndices {
            randomKeys.append(keys[randomIndex])
        }
        
        //set as labels
        for i in 0..<suggestionButtonViewCollection.count{
            suggestionButtonViewCollection[i].setTitle(randomKeys[i], for: .normal)
        }
    }
    
    @discardableResult
    func getRandomWord() -> String{
        return wordDict.randomElement()!.key
    }
}
