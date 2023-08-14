//: [Previous](@previous)

import Foundation

let json = """
{
    "quote": "The will of man is his happiness.",
    "author": "Friedrich Schiller",
    "category": "happiness"
  }
"""

struct Quote: Decodable{
    let quote: String
    let author: String
    let category: String
}
//String -> data -> Quote struct

//data -> Quote
//Error Handling, Do Try Catch, Meta Type
guard let result = json.data(using: .utf8) else{
    fatalError("Error")
}
print(result)
do{
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
    print(value.quote)
    
} catch{
    print(error)
}


//: [Next](@next)
