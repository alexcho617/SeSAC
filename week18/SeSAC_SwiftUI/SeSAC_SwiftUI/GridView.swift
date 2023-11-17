//
//  GridView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/17.
//

import SwiftUI

struct GridView: View {
    @Binding var movie: [Movie]
    var ddummy = Array(1...100).map { num in
        "오늘의 영화 순위 \(num)"
    }
//    private let layout = [
//        GridItem(.fixed(120)),
//        GridItem(.fixed(120)),
//        GridItem(.fixed(120))
//    ]
    
//    private let layout = [
//        GridItem(.flexible(minimum: 100, maximum: 200)),
//        GridItem(.flexible(minimum: 100, maximum: 200)),
//        GridItem(.flexible(minimum: 100, maximum: 200)),
//
//    ]
    
        private let layout = [
            GridItem(.flexible(),spacing: 20),
            GridItem(.flexible(),spacing: 20),
            GridItem(.flexible(),spacing: 20),
        ]
        
//    private let layout = [
//        GridItem(.adaptive(minimum: 100)),
//        GridItem(.adaptive(minimum: 100)),
//        GridItem(.adaptive(minimum: 100))
//    ]
    var body: some View {
        //Grid의 장점 = 가로뷰 쉽게 대응
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(ddummy, id: \.self) {item in
                    ZStack {
                        Color.random()
                        Text(item)
                    }
                }
            }.padding()
        }
        .onAppear {
            print("ON APPEAR")
            print("HEAVY NETWORK REQUEST")
        }
        .task {
            print("DODODO")
        }
        
//        List{
//            ForEach(ddummy, id: \.self) {item in
//                Text(item)
//            }
//        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(movie: .constant(
        [
            Movie(name: "SF"),
            Movie(name: "Sci Fis")
        ]
        ))
    }
}
