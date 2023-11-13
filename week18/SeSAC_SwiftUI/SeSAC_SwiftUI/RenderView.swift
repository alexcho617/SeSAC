//
//  RenderView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/13.
//

import SwiftUI

struct RenderView: View {
    var bran: some View{
        Text("Bran, \(Int.random(in: 1...100))")
    }
    
    @State var age = 10
    
    var body: some View {
        //버튼 클릭시 extract view로 따로 빼놓은 뷰를 제외하고 전부 다 값이 바뀜
        VStack {
            Text("Hue, \(age), \(Int.random(in: 1...100))")
            Text("Jack, \(Int.random(in: 1...100))")
            bran
            Koko()
            Button("CLicke") {
                age = Int.random(in: 1...100)
            }
        }
    }
}

struct RenderView_Previews: PreviewProvider {
    static var previews: some View {
        RenderView()
    }
}

//버튼 클릭시 extract view로 따로 빼놓은 뷰를 제외하고 전부 다 값이 바뀜
struct Koko: View {
    var body: some View {
        Text("Koko, \(Int.random(in: 1...100))")
    }
}
