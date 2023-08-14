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
        concurrentAsyncMultiple()
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
        for i in 1...500{
            DispatchQueue.global().async {
                sleep(1)
                print(i, "isMain:", Thread.isMainThread, terminator: " ")
            }
            
        }
        for i in 101...110{
            sleep(1)
            print(i, "isMain:", Thread.isMainThread, terminator: " ")
        }
        print("End")
        
    }
}
