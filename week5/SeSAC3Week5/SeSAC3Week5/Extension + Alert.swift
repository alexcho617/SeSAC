//
//  Extension + Alert.swift
//  SeSAC3Week5
//
//  Created by Alex Cho on 2023/08/17.
//

import UIKit

extension UIViewController{
    func showAlert(title: String, message: String, buttonTitle: String, completionHandler: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { action in
            completionHandler()
            print(action, "in action")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert,animated: true)
    }
}
