//: [Previous](@previous)

import Foundation
import UIKit

//
//print("HELLO")
//
////Main Serial Async
//DispatchQueue.main.async{
//    for i in 1...100{
//        print(i, terminator: " ")
//    }
//
//}
//
//
//
//for i in 1...200{
//    print(i, terminator: " ")
//}
//print("BYE")


//------------

print("Hello")
for i in 1...100{
    //Global Concurrent Sync
    //Hello 끝날때까지 기다리게 됨
    DispatchQueue.global().async{
        print(i, terminator: " ")
    }
}

for i in 101...200 {
    print(i, terminator: " ")
}
print("bye")




//: [Next](@next)

