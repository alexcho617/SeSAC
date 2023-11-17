//
//  ChartView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/17.
//

import SwiftUI
import Charts
struct ChartView: View {
    let movies: [Movie]
    
    @Environment(\.colorScheme) var color
    
    
    //ViewBuilder property wrapper with copmuted property
    @ViewBuilder //원래 다 뷰 빌더를 써줬어야는데 이제 생략 가능해짐. 이미 viewbuilder가 내장
    //이 경우에는 조건에 따라서 경우의 수가 발생하여 ViewBuilder를 써줘야했음
    var chartTitle: some View{
//        Text(color == .dark ? "Dark Chart" : "Light Chart")
        if color == .dark{
            Text("Dark Chart")
        }else{
            Text("Light Chart")
        }
    }
    
    var body: some View {
        VStack{
            chartTitle
            Chart(movies, id: \.self) { item in
//                BarMark
//                LineMark
//                AreaMark
                RectangleMark(
                    x: .value("Movie", item.name),
                    y: .value("Count", item.count)
                ).foregroundStyle(Color.random())

            }
            .padding()
            .frame(height: 300)
        }
    }
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(movies: [Movie(name: "The Movie"), Movie(name: "Another Movie")])
    }
}
