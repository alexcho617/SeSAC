//
//  TabBadgeView.swift
//  VersionControl
//
//  Created by Alex Cho on 11/23/23.
//

import SwiftUI

struct TabBadgeView: View {
    var body: some View {
        TabView{
            ForEach(TabItem.allCases, id: \.hashValue) { item in
                item.rootView
                    .tabItem { item.image }
            }
        }
//        .tabViewStyle(.page) //UIKit pagecontroller
    }
}

extension TabBadgeView {
    private enum TabItem: CaseIterable{
        case home
        case favorite
        case chat
        case setting
        
        var image: Image{
            switch self {
            case .home:
                Image(systemName: "house")
            case .favorite:
                Image(systemName: "star.fill")
            case .chat:
                Image(systemName: "character.bubble")
            case .setting:
                Image(systemName: "gear")
            }
        }
        //some -> opaque type
        //Branches have mismatching types 'ContentView' and 'ZStack<TupleView<(Color, Text)>>' 같은 타입을 반환하라는 뜻
        //따라서 some을 쓰는것
        @ViewBuilder
        var rootView: some View{
            switch self {
            case .home:
                ContentView()
            case .favorite:
                ZStack{
                    Color.gray
                    Text("Fav View")
                }
            case .chat:
                ZStack{
                    Color.gray
                    Text("Chat View")
                }
            case .setting:
                ZStack{
                    Color.gray
                    Text("Set View")
                }
            }
        }
    }
}

#Preview {
    TabBadgeView()
}
