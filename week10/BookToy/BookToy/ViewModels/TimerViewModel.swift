//
//  TimerViewModel.swift
//  BookToy
//
//  Created by Alex Cho on 2023/09/24.
//

import Foundation

class TimerViewModel{
    
    enum TimerState{
        case on
        case off
    }
    let timer = Timer()
    //TODO: Check from UD if timer was going on
    var timerState: Observable<TimerState>
    
    init() {
        self.timerState = Observable(.off) //#VALUE FROM UserDefaults
    }

    
    func mainButtonClicked(){
        switch timerState.value{
        case .on:
            print("Turned Off")
            timerState.value = .off
        case .off:
            print("Turned On")
            timerState.value = .on
        }
    }
    func stopButtonClicked(){
        print(#function)
    }
}
