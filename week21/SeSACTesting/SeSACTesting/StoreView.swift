//
//  StoreView.swift
//  SeSACTesting
//
//  Created by Alex Cho on 12/18/23.
//

import SwiftUI
import StoreKit

struct StoreView: View {
    @StateObject var shop = SeSACShop()
    
    
    var body: some View {
        VStack {
            HStack{
                Text("광고 제거")
                Spacer()
                Button("$99.99") {
                    print("Click")
                }
            }.padding()
            
            ForEach(shop.allProducts, id: \.id){ item in
                ProductView(item)
                    .productViewStyle(.compact)
                HStack {
                    Text(item.displayName)
                    Spacer()
                    Text(item.displayPrice)
                }.padding()
            }
            //StoreView()
            //SubscriptionStoreView
            
        }
        .task {
            await shop.fetchAllProducts()
        }
    }
}

#Preview {
    StoreView()
}
