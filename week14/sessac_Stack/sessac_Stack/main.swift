//
//  main.swift
//  sessac_Stack
//
//  Created by Alex Cho on 2023/10/19.
//

import Foundation

//MARK: Attempt using just array
let n = Int(readLine()!)!

for _ in 1...n{
    let input = readLine()!.split(separator: "")
    if validate(input){
        print("YES")
    }else{
        print("NO")
    }
}

func validate(_ input: Array<Substring>) -> Bool{
    var stack: Array<Substring> = []
    for bracket in input{
        if bracket == "("{
            stack.append(bracket)
        }else{
            if stack.isEmpty{
                return false
            }else{
                stack.popLast()
            }
        }
    }
    return stack.isEmpty ? true : false
}
