//: [Previous](@previous)

import Foundation


let json = """
{
    "quote": "The will of man is his happiness.",
    "author": "Friedrich Schiller",
    "cg": "happiness"
  }
"""


//String -> data -> Quote struct

//data -> Quote
//Error Handling, Do Try Catch, Meta Type
//키 값이 다르면 디코딩 실패
//옵셔널로 오류 방지 할 수 있음

struct Quote: Decodable{
    let quoteContent: String?
    let authorName: String?
    let category: String?
}

guard let result = json.data(using: .utf8) else{
    fatalError("Error")
}
print(result)
do{
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
    
    
} catch{
    print(error)
}

//: [Next](@next)
