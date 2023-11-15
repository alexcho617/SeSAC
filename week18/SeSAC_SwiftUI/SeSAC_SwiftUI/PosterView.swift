//
//  PosterView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/15.
//

import SwiftUI

struct PosterView: View {
    @State private var isPresented = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(0..<30){ item in
                    AsyncImageView()
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            isPresented.toggle()
                        }
                }
            }
        }
        .background(.gray)
        .sheet(isPresented: $isPresented) {
            CategoryView()
        }
//        xcode 15
//        .contentMargines(50, for: .scrollContent)

    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView()
    }
}

struct AsyncImageView: View{
    let url = URL(string: "https://picsum.photos/300")
    var body: some View{
        AsyncImage(url: url){ data in
            switch data{
            case .empty:
                ProgressView()
                    .frame(width: 100, height: 100)
            case .success(let image):
                image
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            case .failure(let error):
                Text(error.localizedDescription)
            @unknown default:
                Image(systemName: "star")
            }
        }

    }
}

//
//struct AsyncImageView: View{
//    let url = URL(string: "https://picsum.photos/400")
//    var body: some View{
//        AsyncImage(url: url) { image in
//            image
//                .resizable()
//                .frame(width: 300,height: 100)
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//        } placeholder: {
////            Text("Loading")
//            ProgressView()
//        }
//
//    }
//}
