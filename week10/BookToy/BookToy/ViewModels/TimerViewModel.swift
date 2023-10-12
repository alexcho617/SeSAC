//
//  TimerViewModel.swift
//  BookToy
//
//  Created by Alex Cho on 2023/09/24.
//

import Foundation
import MagicTimer
enum TimerState{
    case on
    case off
}
class TimerViewModel{
    
    var currentTime: Observable<TimeInterval> = Observable(0.0)
    let timer = MagicTimer()
    
    //TODO: Check from UD if timer was going on
    var timerState: Observable<TimerState>
    
    init() {
        
        self.timerState = Observable(.off) //#VALUE FROM UserDefaults
        setTimer()
    }
    func setTimer(){
        timer.countMode = . stopWatch
        timer.defultValue = 0
        timer.effectiveValue = 1
        timer.timeInterval = 1
        timer.isActiveInBackground = true
        timer.observeElapsedTime = observe(time:)
    }
    
    func observe(time: TimeInterval) -> Void{
        //update view
        print("현재 시간:",currentTime.value)
        currentTime.value = time
        
    }
    
    func mainButtonClicked(){
        switch timerState.value{
        case .on:
            print("Turned Off")
            timerState.value = .off
            timer.stop()
        case .off:
            print("Turned On")
            timerState.value = .on
            timer.start()
        }
    }
    func stopButtonClicked(){
        print(#function)
        timer.reset()
        currentTime.value = 0.0
        timerState.value = .off
    }
}
