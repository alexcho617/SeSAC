//
//  NumberViewModel.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/18.
//

import Foundation

class NumberViewModel{
    var number: Observable<String?> = Observable("1")
    var result = Observable("1,327")
    func convertNumber(){
        guard let text = number.value else {
            result.value = "값을 입력해주세요"
            return
        }
        guard let num = Double(number.value ?? "") else {
            result.value = "올바른 숫자를 입력해주세요"
            return
            
        }
        
        guard num > 0, num < 1000000 else {
            result.value = "0~100만원 사이만 가능"
            return
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let decimalNumber = formatter.string(for: num * 1327)!
        result.value = "환전 금액은\(decimalNumber)입니다"
    }
}
