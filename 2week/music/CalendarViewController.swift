//
//  CalendarViewController.swift
//  music
//
//  Created by Alex Cho on 2023/07/25.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("CalendarViewController", #function)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("CalendarViewController", #function)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("CalendarViewController", #function)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("CalendarViewController", #function)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("CalendarViewController", #function)
    }
    
    
    
    
    
    @IBAction func unwindToCalendar(_ unwindSegue: UIStoryboardSegue) {
        
    }
}
