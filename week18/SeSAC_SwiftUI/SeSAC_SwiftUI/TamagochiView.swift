//
//  TamagochiView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/14.
//

import SwiftUI

//UI depends on Data to determine their state
struct TamagochiView: View {
    //얘가 달라지면 렌더링. 질문: didset{reloadview}랑 차이가 있나? 전체를 그리나 아니면 해당 뷰만 그리나
    //SourceOfTruth View에 대한 상태를 저장하기 위한 목적, State Property
    @State private var riceCount = 0
    @State private var waterCount = 0
    @State private var isOn = false
    @State private var textInput = ""
    //@Binding. Derived Value -> 파생된 데이터
    //사실 연산프로퍼티고 getter를 생략했음
    var body: some View {
        VStack {
            TextField("밥 알 갯수 입력", text: $textInput)
                .padding()
            Toggle(isOn: $isOn) {
                Text("Switch")
            }
            .padding()
            
            ExtractedView(title: "밥알", count: $riceCount)
            ExtractedView(title: "물", count: $waterCount)
            
            //click영역은 그대로임
            Button("Feed") {
                riceCount += Int(textInput) ?? 0
            }
            .padding(20)
            .background(.green)
            
            //click 영역 자체가 늘어남
            Button {
                print("HI")
                waterCount += 2
            } label: {
                Text("Drink")
                .padding(20)
                .background(.mint)
                
            }
            
        }.background(.yellow)
    }
}

struct TamagochiView_Previews: PreviewProvider {
    static var previews: some View {
        TamagochiView()
    }
}

//하위 뷰 에선 바인딩으로 연결 해야함
struct ExtractedView: View {
    var title: String
    @Binding var count: Int
    
    var body: some View {
        HStack {
            Button {
                count += 1
            } label: {
                Text("+")
            }

            Text("\(title)갯수 \(count)개")
                .background(.black)
                .foregroundStyle(.white)
            .font(.title)
        }
    }
}
