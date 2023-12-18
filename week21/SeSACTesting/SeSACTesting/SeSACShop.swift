//
//  SeSACShop.swift
//  SeSACTesting
//
//  Created by Alex Cho on 12/18/23.
//

import Foundation
import StoreKit

class SeSACShop: ObservableObject{
    @Published var allProducts: [Product] = [] //인앱 조회시 상품을 담아 줄 배열
    
    func fetchAllProducts() async {
        do {
            let product = try await Product.products(for: [
                "com.alexcho617.SeSACTesting.diamond100",
                "com.alexcho617.SeSACTesting.diamond200"
            ])
            
            allProducts = product
        } catch {
            print(error)
        }
    }
}
