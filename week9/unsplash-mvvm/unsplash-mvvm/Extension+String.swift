//
//  Extension+String.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/11.
//

import Foundation
extension String{
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
}

//
//let value = NSLocalizedString("nickname_result", comment: "")
//label.text = String(format: value, name)
