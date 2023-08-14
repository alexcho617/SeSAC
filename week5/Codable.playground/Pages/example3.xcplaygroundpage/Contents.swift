//: [Previous](@previous)

import Foundation

let json = """
{
    "quote_content": "The will of man is his happiness.",
    "author_name": "Friedrich Schiller",
  }
"""
//snake case to camelcase
struct Quote: Decodable{
    let quoteContent: String
    let authorName: String
}
//String -> data -> Quote struct

//data -> Quote
//Error Handling, Do Try Catch, Meta Type
guard let result = json.data(using: .utf8) else{
    fatalError("Error")
}
print(result)

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
do{
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
    
} catch{
    print(error)
}

//: [Next](@next)
