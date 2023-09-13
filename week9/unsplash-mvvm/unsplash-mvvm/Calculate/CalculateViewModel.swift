//
//  CalculateViewModel.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/13.
//

import Foundation

class CalculateViewModel{
    var firstNumber: CustomObservable<String?> = CustomObservable("3")
    var secondNumber: CustomObservable<String?> = CustomObservable("7")
    var result: CustomObservable<String?> = CustomObservable("결과는 10입니다")
    var tempText = CustomObservable("testing")
    
    func format(for number: Int) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(for: number) ?? ""
    }
    
    func calculate(){
        //첫번째 숫자 먼저 확인하기 때문에 둘 다 에러라면 첫번째에서 걸러짐
        guard let first = firstNumber.value, let firstConverted = Int(first) else {
            result.value = "첫번째 값에서 오류가 발생했습니다"
            return
        }
        
        guard let second = secondNumber.value, let secondConverted = Int(second) else {
            result.value = "두번쨰 값에서 오류가 발생했습니다"
            return
        }
        
        let res = firstConverted + secondConverted
        result.value = "결과는 \(res)입니다"
    }
    
    func presentNumberFormat(){
        //첫번째 숫자 먼저 확인하기 때문에 둘 다 에러라면 첫번째에서 걸러짐
        guard let first = firstNumber.value, let firstConverted = Int(first) else {
            result.value = "첫번째 값에서 오류가 발생했습니다"
            return
        }
        
        let res = firstConverted
        tempText.value = format(for: res)
    }
    
}
