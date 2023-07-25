//
//  DateViewController.swift
//  NewlyCoinedWord
//
//  Created by Alex Cho on 2023/07/20.
//

import UIKit

class DateViewController: UIViewController {

    //globals
    let df = DateFormatter()
    
    //outlets
    @IBOutlet var background100View: UIView!
    
    @IBOutlet var datePickerView: UIDatePicker!
    @IBOutlet var image100View: UIImageView!
    @IBOutlet var label100View: UILabel!
    @IBOutlet var image200View: UIImageView!
    @IBOutlet var label200View: UILabel!
    @IBOutlet var image300View: UIImageView!
    @IBOutlet var label300View: UILabel!
    @IBOutlet var image400View: UIImageView!
    @IBOutlet var label400View: UILabel!
    
    
    //vdl
    override func viewDidLoad() {
        super.viewDidLoad()
        designDatePicker()
        testViewProperty()
        dateChanged(datePickerView)
        df.dateFormat = "MMM dd, yyyy"
    }
    
    //actions
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        //DateFormatter: 1.Time, 2.Date
        let dayAfterHundred = addDate(currentDay: sender.date, by: 100)
        let dayAfterTwoHundred = addDate(currentDay: sender.date, by: 200)
        let dayAfterThreeHundred = addDate(currentDay: sender.date, by: 300)
        let dayAfterFourHundred = addDate(currentDay: sender.date, by: 400)

        var formattedDate = df.string(from: dayAfterHundred)
        label100View.text = formattedDate
        
        formattedDate = df.string(from: dayAfterTwoHundred)
        label200View.text = formattedDate
        
        formattedDate = df.string(from: dayAfterThreeHundred)
        label300View.text = formattedDate
        
        formattedDate = df.string(from: dayAfterFourHundred)
        label400View.text = formattedDate
    }
 
    func addDate(currentDay: Date, by interval: Int) -> Date{
        let result = Calendar.current.date(byAdding: .day, value: interval, to: currentDay)!
        return result
    }
    
    func testViewProperty(){
        //backgroundview for shadow effect
        background100View.layer.shadowColor = UIColor.black.cgColor
        background100View.layer.shadowOffset = .zero
        background100View.layer.shadowRadius = 10
        background100View.layer.shadowOpacity = 0.5
        background100View.clipsToBounds = false
        background100View.layer.cornerRadius = 20
        
        //image clip
        image100View.layer.cornerRadius = 20
        image100View.clipsToBounds = true //클립해버리면 겉부분을 지우는거기 때문에 그림자도 같이 지워진다. 따라서 그림자를 위한 뷰를 따로 만들어준다.
        
    }
    func designDatePicker(){
        if #available(iOS 14.0, *) {
            datePickerView.preferredDatePickerStyle = .inline
        } else {
            // Fallback on earlier versions
            datePickerView.preferredDatePickerStyle = .wheels

        }
    }

}
