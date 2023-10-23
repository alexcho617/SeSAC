//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

//let inp = "1 2 3 4 5"
//let arr = inp.components(separatedBy: " ").map { Int($0)! }
//print(arr)
//let arr2 = inp.split(separator: " ").map { Int($0)! }
//print(arr2)


var array: [Int] = [1,2]
array.reserveCapacity(4)
print("capacity :", array.capacity)
print(array)
array.withUnsafeBytes {
    print($0)
}

array.append(3)
print("capacity :", array.capacity)
print(array)
array.withUnsafeBytes {
    print($0)
}

array.append(4)
print("capacity :", array.capacity)
print(array)
array.withUnsafeBytes {
    print($0)
}

array.append(5)
print("capacity :", array.capacity)
print(array)
array.withUnsafeBytes {
    print($0)
}

array.popLast()
print("capacity :", array.capacity)
print(array)
array.withUnsafeBytes {
    print($0)
}

array.popLast()
print("capacity :", array.capacity)
print(array)
array.withUnsafeBytes {
    print($0)
}

array.popLast()
print("capacity :", array.capacity)
print(array)
array.withUnsafeBytes {
    print($0)
}

array.popLast()
print("capacity :", array.capacity)
print(array)
array.withUnsafeBytes {
    print($0)
}

array.popLast()
print("capacity :", array.capacity)
print(array)
array.withUnsafeBytes {
    print($0)
}


