//: [Previous](@previous)

import Foundation

let json = """
{
    "quote_content": "The will of man is his happiness.",
    "author_name": null,
    "likelike":1234
  }
"""
//snake case to camelcase
struct Quote: Decodable{
    let quote: String
    let name: String
    let like: Int
    let isInfluencer: Bool
    
    enum CodingKeys: String, CodingKey {
        case quote = "quote_content"
        case name = "author_name"
        case like = "likelike" //같으면 생략
    }
    
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        quote = try container.decode(String.self, forKey: .quote)
        like = try container.decode(Int.self, forKey: .like)
        isInfluencer = (3000...).contains(like) ? true : false
        name = (try? container.decodeIfPresent(String.self, forKey: .name)) ?? "작자미상"
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
