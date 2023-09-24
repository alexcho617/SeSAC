//
//  TimerViewModel.swift
//  BookToy
//
//  Created by Alex Cho on 2023/09/24.
//

import Foundation

class TimerViewModel{
    let timer = Timer()
    //TODO: Check from UD if timer was going on
//    var isTimerOn = Observable(#valueFromUserDefaults)

    var isTimerOn = Observable(false)
    func mainButtonClicked(){
        if isTimerOn.value{
            print("Turned Off")
            isTimerOn.value.toggle()
        }else{
            print("Turned On")
            isTimerOn.value.toggle()
        }
    }
    func stopButtonClicked(){
        print(#function)
    }
}
