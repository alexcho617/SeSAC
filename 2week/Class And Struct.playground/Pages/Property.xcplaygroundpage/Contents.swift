//: [Previous](@previous)

import Foundation
import UIKit
enum DrinkSize{
    case short,tall,grande,venti
}

class DrinkClass{
    init(name: String, price: Int, size: DrinkSize) {
        self.name = name
        self.price = price
        self.size = size
    }
    
    let name: String
    var price: Int
    var size: DrinkSize
}
struct DrinkStruct{
    let name: String
    var price: Int
    var size: DrinkSize
}
//
//let drinkClass = DrinkClass(name: "아샷추", price: 3400, size: .grande)
////drink.name = "아샷추를?"
//drinkClass.price = 4000
//drinkClass.size = .venti
//
//let drinkStruct = DrinkStruct(name: "아샷추", price: 3400, size: .grande)
//drinkStruct.name = "샷아추"
//drinkStruct.price = 3600
//drinkStruct.size = .tall


struct Poster{
    var image: UIImage = UIImage(systemName: "star") ?? UIImage()
}

struct Movie{
    static let best = "movie of the month" //stored type property(stored and type)
    //statics by default acts like lazy stored property. no need lazy keyword
    //https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Lazy-Stored-Properties
    let name: String
    let runtime: Int
    lazy var video: Poster =  Poster()
    //lazy: lazy store property
    //https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Lazy-Stored-Properties
}

let media = Movie(name: "Cross Landong on You", runtime: 130)
Movie.best//placed on memory when called. stays until app terminates

//: [Next](@next)


