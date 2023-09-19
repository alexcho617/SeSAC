//
//  ViewController.swift
//  combine-textfield-tutorial
//
//  Created by Alex Cho on 2023/09/19.
//

import UIKit
import Combine
class ViewController: UIViewController {
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var pwCheckTextField: UITextField!
    
    @IBOutlet weak var myButton: UIButton!
    
    private var mySubscription = Set<AnyCancellable>()
    var vm = MyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view -> vm
        pwTextField
            .myTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.pwInput, on: vm)
            .store(in: &mySubscription)
        
        pwCheckTextField
            .myTextPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.pwInputCheck, on: vm)
            .store(in: &mySubscription)
        
        //viewmodel -> view
        vm.isPasswordMatch
            .receive(on: RunLoop.main)
            .assign(to: \.isValid , on: myButton)
            .store(in: &mySubscription)

    }
}

extension UITextField{
    var myTextPublisher: AnyPublisher<String, Never>{
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap{$0.object as? UITextField}
            .map{$0.text ?? ""}
            .print() //clean up data
            .eraseToAnyPublisher()
    }
}
 
extension UIButton{
    var isValid: Bool{
        get{
            backgroundColor == .lightGray
        }
        set{
            backgroundColor = newValue ? .yellow : .lightGray
            isEnabled = newValue
            setTitleColor(newValue ? .blue : .white, for: .normal)
        }

    }
}
