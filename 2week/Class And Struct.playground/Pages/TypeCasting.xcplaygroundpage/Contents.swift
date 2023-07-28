//: [Previous](@previous)

import Foundation

//형변환 -> Type Casting
let number = 3
let strNumber = String(number) //Uses initializer to make new isntance and return it

type(of: number)
type(of: strNumber)

class Mobile{
//    let name: String = "MOBILE NAME" //declare and init at same time
    let name: String
    
    //separate declare and initialize
    init(name:String){ //initilize when used
        self.name = name
    }
}

class Google: Mobile{
    
}

class Apple: Mobile{
    let conference:String = "WWDC"
}
//is: Check instance of which class
let mobile = Mobile(name: "MOBILE NAME")
let goog = Google(name: "GOOGLE")
let apple = Apple(name: "APPLE")

mobile is Mobile
mobile is Apple
mobile is Google

apple is Apple
apple is Mobile
apple is Google

//Mobile is like UITableViewCell, Apple is like CustomTableViewCell
let iPhone: Mobile = Apple(name: "iPhone 12") //put child class into parent type constant, but only able to get parent's
type(of: iPhone)
iPhone.name
//iPhone.conference //but cannot get conference property

//type cast to get access
//Type cast operater: as(Upcasting to parent class) / as? as! (Downcasting to child class)
//as? return nil on failure
//as! runtime error on failure

if let value = iPhone as? Apple{
    print(value.conference)
}
if let value = iPhone as? Google{ //cannot downcast
//    print(value.conference)error
    print(value)
    type(of: value)
}else{
    print("downcast fail")
}

///
///Any: Can hold instance of all types vs AnyObject: can hold only instance of class
///It is decided at runtime
var something: [Any] = ["a","b","c",true]
//var something: [AnyObject] = ["a","b","c",true]
something.append(0)
something.append(false)
something.append("d")
something.append(mobile)

print(something)
print(something[4])
let element = something[4]


if let value = element as? Int{
    print(element)
} else{
    print("not int")
}



if let value = element as? String{
    print(element)
} else{
    print("not string")
}


//: [Next](@next)
