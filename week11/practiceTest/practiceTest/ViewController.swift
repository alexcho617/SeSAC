//
//  ViewController.swift
//  practiceTest
//
//  Created by Alex Cho on 2023/09/26.
//

import UIKit

class ViewController: UIViewController {
    let vm = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(vm.myBool)
        vm.toggleMyBool()
        print(vm.myBool)
    }


}

