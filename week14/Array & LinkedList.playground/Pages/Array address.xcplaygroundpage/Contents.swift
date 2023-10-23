//: [Previous](@previous)

import Foundation

var arr = ["aa", "bbbbb", "cccccccc"]
for i in 0..<3 {
    withUnsafePointer(to: &arr[i]) {
        print("string arr", $0)
    }
}

var arr2 = [0, 1, 2, 3]
for i in 0..<4 {
    withUnsafePointer(to: &arr2[i]) {
        print("Int arr", $0)
    }
}

