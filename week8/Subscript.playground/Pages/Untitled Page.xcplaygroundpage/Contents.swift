import UIKit



extension String{
    subscript(idx: Int) -> String? {
        guard (0..<count).contains(idx) else{
            return nil
        }
        
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
        
    }
}
var greeting = "Hello, playground"

greeting.count
//greeting.index(startIndex, offsetBy: 2)
greeting[2]
greeting[100]


//var number = [1,2,3]
//number[10] //이걸 런타임 에러 말고

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
var number = [1,2,3]
//number[10]
number[safe: 10] //runtime error 방지
number[safe: 1]
