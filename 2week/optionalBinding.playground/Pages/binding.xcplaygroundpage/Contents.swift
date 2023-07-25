import UIKit

var name:String? = "alex"
var age: Int?
//force unwrap
print(name)

//optional binding
if let name = name{
    print(name)
}
testOptionalBinding()

func testOptionalBinding(){
//    //swift 5.7 if let shortened
    if let name{
        print(name)//name 안에서만 사용 가능
    }
    guard let name else {
        print("nil")
        return // early exit
    }
    print("Rest of code")
    print(name)
}
