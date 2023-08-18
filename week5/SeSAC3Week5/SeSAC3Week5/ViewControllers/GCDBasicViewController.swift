//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        serialSync()
        //        serialAsync()
        //        concurrentSync()
        //        concurrentAsyncMultiple()
        groupTask()
    }
    
    func groupTask(){
        let group = DispatchGroup()
        
        DispatchQueue.global(qos: .userInitiated).async(group: group) {
            for i in 1...100{
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global(qos: .background).async(group: group) {
            for i in 101...200{
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global(qos: .background).async(group: group) {
            for i in 201...300{
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global(qos: .background).async(group: group) {
            for i in 301...400{
                print(i, terminator: " ")
            }
        }
        //UI update at main so generally notified at main
        group.notify(queue: .main){
            //update view etc
            print("Done")
        }
        
    }
    
    
    func serialAsync(){
        print("Start")
        
        DispatchQueue.main.async {
            for i in 1...10{
                sleep(1)
                print(i, terminator: " ")
            }
        }
        for i in 11...20{
            sleep(1)
            print(i, terminator: " ")
        }
        print("End")
        
    }
    
    func serialSync() {
        print("Start")
        
        for i in 1...10 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        DispatchQueue.main.sync { //에러, Deadlock 발생
            for i in 101...200 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        print("End")
    }
    
    func concurrentSync(){
        print("Start")
        DispatchQueue.global().sync {
            for i in 1...5{
                sleep(1)
                print(i, "isMain:", Thread.isMainThread)
            }
        }
        for i in 6...10{
            sleep(1)
            print(i, "isMain:", Thread.isMainThread)
        }
        print("End")
    }
    
    func concurrentAsync(){
        print("Start")
        DispatchQueue.global().async {
            for i in 1...5{
                sleep(1)
                print(i, "isMain:", Thread.isMainThread)
            }
        }
        for i in 6...10{
            sleep(1)
            print(i, "isMain:", Thread.isMainThread)
        }
        print("End")
    }
    
    func concurrentAsyncMultiple(){
        print("Start")
        for i in 100...500{
            DispatchQueue.global().async {
                sleep(1)
                print(i, Thread.isMainThread, terminator: " ")
                //                print(i, "isMain:", Thread.isMainThread, terminator: " ")
            }
            
        }
        for i in 1...10{
            sleep(1)
            print(i, Thread.isMainThread, terminator: " ")
        }
        print("End")
        
    }
}
