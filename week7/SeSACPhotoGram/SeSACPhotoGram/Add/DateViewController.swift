//
//  DateViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit

class DateViewController: BaseViewController {
    
    private let mainView = DateView()
    
    var delegate: PassDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    deinit {
        print("deinit", self)
    }
    
    //어느 시점에 함수를 실행할지 정함
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
        delegate?.receiveDate(date: mainView.datePicker.date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        delegate?.receiveDate(date: mainView.datePicker.date) //여기서 호출하면 왜 안됨?
        
    }
    
}
