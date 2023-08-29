//
//  AlertManager.swift
//  TMDBHelperFramework
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit
extension UIViewController{
    public func showAlert(title: String, message: String, buttonTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert,animated: true)
        
    }
}

