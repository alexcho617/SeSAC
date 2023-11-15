//
//  StartView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/15.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Text("Home")
                    Image(systemName: "house.fill")
                }
            CategoryView()
                .tabItem {
                    Text("Search")
                    Image(systemName: "pencil")
                }
            RenderView()
                .tabItem {
                    Text("Setting")
                    Image(systemName: "star")
                }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
