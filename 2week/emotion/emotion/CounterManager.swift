//
//  CounterManager.swift
//  emotion
//
//  Created by Alex Cho on 2023/07/25.
//

import Foundation
class CounterManager{
    private var orderedKeys = [
        "emoji0",
        "emoji1",
        "emoji2",
        "emoji3",
        "emoji4"
    ]

    func increment(_ emotion: String, by incrementValue: Int){
        //get
        let oldValue = UserDefaults.standard.integer(forKey: emotion)
        //add
        let newValue = oldValue + incrementValue
        //set
        UserDefaults.standard.setValue(newValue, forKey: emotion)
        printCounterStatus()
    }
    
    func resetCounterInUserDefaults(){
        for key in orderedKeys{
            UserDefaults.standard.setValue(0, forKey: key)
        }
        printCounterStatus()
    }
     
    func printCounterStatus(){
        for key in orderedKeys{
            let value = UserDefaults.standard.integer(forKey: key)
            print(key,value,separator: " ", terminator: " ")
        }
        print()
    }
}
