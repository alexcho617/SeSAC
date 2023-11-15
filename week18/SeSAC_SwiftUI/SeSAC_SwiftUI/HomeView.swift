//
//  HomeView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/15.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ScrollView(.horizontal) {
                    LazyHStack{
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                    }
                }
                ScrollView(.horizontal) {
                    LazyHStack{
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                    }
                }
                ScrollView(.horizontal) {
                    LazyHStack{
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                    }
                }
                ScrollView(.horizontal) {
                    LazyHStack{
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                    }
                }
                ScrollView(.horizontal) {
                    LazyHStack{
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                    }
                }
                ScrollView(.horizontal) {
                    LazyHStack{
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
