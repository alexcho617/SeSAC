//: [Previous](@previous)

import Foundation

let json = """
{
    "quote_content": "The will of man is his happiness.",
    "author_name": "Friedrich Schiller",
    "likelike":1234
  }
"""
//snake case to camelcase
struct Quote: Decodable{
    let quote: String
    let name: String
    let like: Int
    
    enum CodingKeys: String, CodingKey {
        case quote = "quote_content"
        case name = "author_name"
        case like = "likelike" //같으면 생략
    }
}
//String -> data -> Quote struct

//data -> Quote
//Error Handling, Do Try Catch, Meta Type
guard let result = json.data(using: .utf8) else{
    fatalError("Error")
}
print(result)

let decoder = JSONDecoder()
do{
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
    
} catch{
    print(error)
}
//: [Next](@next)
