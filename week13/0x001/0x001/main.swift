//
//  main.swift
//  0x001
//
//  Created by Alex Cho on 2023/10/12.
//

import Foundation

//var a = Int(readLine()!)!
//var b = Int(readLine()!)!
//
//print("\(a+b)")

let input = readLine()!.components(separatedBy: " ").map { val in
    Int(val)!
}
print(input[0] + input[1])

