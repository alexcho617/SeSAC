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
        NavigationView {
            VStack {
                HStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.red]), startPoint: .leading, endPoint: .trailing)
                        )
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                        )
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .leading, endPoint: .trailing)
                        )
                }.frame(width: UIScreen.main.bounds.width - 20, height: 100)
                
                HStack{
                    RadialGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), center: .center, startRadius: 20, endRadius: 70)
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            AngularGradient(colors: [.yellow, .purple], center: .center, angle: .degrees(270))
                        )
                }.frame(width: UIScreen.main.bounds.width - 20, height: 100)
                
                //근데 이건 데이터 기반이 아니지
                NavigationLink("Push"){
                    MenuView()
                }
                Text("Hue, \(age), \(Int.random(in: 1...100))")
                Text("Jack, \(Int.random(in: 1...100))")
                bran
                Koko()
                Button("CLicke") {
                    age = Int.random(in: 1...100)
                }
            }
            //UIKIt storyboard에서도 타이틀을 네비콘트롤러 하위 뷰에서 정해줬음
            .navigationTitle("HOME")
                .navigationBarItems(leading: Button("Leftie", action: {
                    print("Leftie")
                }))
                .navigationBarItems(trailing: Button("Rightie", action: {
                    print("Rightie")
                }))
        }
        //버튼 클릭시 extract view로 따로 빼놓은 뷰를 제외하고 전부 다 값이 바뀜
        
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
