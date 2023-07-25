//
//  CounterManager.swift
//  emotion
//
//  Created by Alex Cho on 2023/07/25.
//

import Foundation
class CounterManager{
    
    
    private var counterDict = [
        "emoji1":0,
        "emoji2":0,
        "emoji3":0,
        "emoji4":0,
        "emoji5":0
    ]
    
    private var orderedKeys = [
        "emoji1",
        "emoji2",
        "emoji3",
        "emoji4",
        "emoji5"
    ]
    
    func increment(_ emotion: String, by incrementValue: Int){
//        counterDict[emotion]! += incrementValue
        
        //get
        let oldValue = UserDefaults.standard.integer(forKey: emotion)
        //add
        let newValue = oldValue + incrementValue
        //set
        UserDefaults.standard.setValue(newValue, forKey: emotion)
        
    }
    
    func resetCounterInUserDefaults(){
        for key in orderedKeys{
            UserDefaults.standard.setValue(0, forKey: key)
        }
        printCounterStatus()
    }
    
    func isValid(forKey key : String) -> Bool{
        if counterDict.keys.contains(key){
            return true
        }else{
            return false
        }
    }
    
    func printCounterStatus(){
        for key in orderedKeys{
            let value = UserDefaults.standard.integer(forKey: key)
            print(key,value,separator: " ", terminator: " ")
        }
        print()
    }
    
    func getDict() -> [String:Int]{
        return counterDict
    }
    func getOrderedKeys() -> [String]{
        return orderedKeys
    }
}
