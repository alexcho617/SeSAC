//
//  WidgetTabView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/30/23.
//

import SwiftUI

struct WidgetTabView: View {
    @State private var selectedTab = ""
    
    var body: some View {
        TabView(selection: $selectedTab){
            Button("Go to star", action: {
                selectedTab = "star"
            })
            .tabItem {Image(systemName: "book")}
            .tag("book")
            
            Text("2")
                .tabItem {
                    Image(systemName: "star")
                }
                .tag("star")
            Text("3")
                .tabItem {
                    Image(systemName: "pencil")
                }
                .tag("pencil")
        }
        //uikit 에선 scenedelegate에서 가능
        .onOpenURL(perform: { url in
            switch url.absoluteString{
            case "bookURL": selectedTab = "book"
            case "favoriteURL": selectedTab = "star"
            default: selectedTab = "pencil"
            }
        })
        
    }
}

#Preview {
    WidgetTabView()
}
