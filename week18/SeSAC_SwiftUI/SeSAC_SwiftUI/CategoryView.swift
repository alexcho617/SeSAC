//
//  CategoryView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/15.
//

import SwiftUI

//Identifiable id 변수 강제
struct Category: Hashable, Identifiable{
    var id = UUID()
//    let id = UUID()
    
    let name: String
    let count: Int
}
struct CategoryView: View {
    let categories = [
        Category(name: "Thriller", count: 1),
        Category(name: "SF", count: 2),
        Category(name: "Action", count: 3),
        Category(name: "Comedy", count: 4),
        Category(name: "Family", count: 5),
        Category(name: "Family", count: 6),
        Category(name: "Family", count: 7)
    ]
    var body: some View {
        VStack {
            ForEach(categories, id: \.id) {item in
                Text("\(item.name), \(item.count)")
                    .font(.largeTitle)
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
