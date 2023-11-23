//
//  ButtonView.swift
//  VersionControl
//
//  Created by Alex Cho on 11/23/23.
//

import SwiftUI
//struct-> init 시점 활용, property -> 정적, func -> 동적(데이터)
struct ButtonView: View {
    var body: some View {
        //action은 바깥으로 바디에 빼면 좀 더 보기 나을지도
        VStack {
            text.asButton {
                print("Text")
            }
            
            image.asButton {
                print("Image")
            }
            
            rectangle.asButton {
                print("rect")
            }
                
        }
    }
    
    var text: some View{
        Text("Hei")
            .padding(30)
            .background(.black)
            .foreground(.white)
            .font(.largeTitle)
            
    }
    
    var image: some View{
        Image(systemName: "person.fill")
            .scaleEffect(2)
            .padding()
            
    }
    
    var rectangle: some View{
        Rectangle()
            .padding()
            .frame(height: 100)
            
    }
}

#Preview {
    ButtonView()
}
