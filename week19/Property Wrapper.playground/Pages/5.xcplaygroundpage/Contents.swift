//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Decimal{
    var defaultValue: String
    var projectedValue = "이건 설명이야"
    var wrappedValue: String{
        get{
            defaultValue
        }
        set{
            //Int 형변환 후 다시 String으로
            let result = Int(newValue)!.formatted() //ios15 formatter
            defaultValue = "\(result)원"
            projectedValue = "이체할 금액은 \(result)원 입니다."
        }
    }
}

struct Example{
    //@State, @Binding, @@Environment(defaultValue: \.keypath)
    @Decimal(defaultValue: "0원")
    
    var number
}

var example = Example()
print(example.number)

example.number = "20000000"

example.number //wrapped value
example.$number //projected value
//: [Next](@next)
