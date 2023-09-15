import UIKit
//Copy On Write
var nickname = "SeSAC"
var newNick = nickname
var newnewNick = nickname
func address(of object: UnsafeRawPointer) -> String{
    let address = Int(bitPattern: object)
    return String(format: "%p", address)
}

//스트링은 주소가 다름
address(of: &nickname)
address(of: &newNick)
address(of: &newnewNick)

var array = Array(repeating: "Alex", count: 100)
var newArray = array
var newnewArray = array

//컬렉션은 주소가 같음
address(of: &array)
address(of: &newArray)
address(of: &newnewArray)

newArray.append("Hi")
newnewArray[0] = "Bye"

address(of: &array)
address(of: &newArray)
address(of: &newnewArray)
