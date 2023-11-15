//
//  SwiftUIView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/14.
//

import SwiftUI

struct MovieView: View {
    @State private var isPresented = false
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Image("forest")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Button {
                    print("navigate")
                    isPresented.toggle()
                    
                } label: {
                    Text("Navigate")
                }

                Spacer()
                
                Image("forest")
                    .resizable()
                    .border(Color.white, width: 2)
                .frame(width: 100, height: 100)
                
                Spacer()
                
                HStack(alignment: .center){
                    Circle()
                        .frame(width: 100,height: 100)
                        .foregroundColor(Color.red)
                    Circle()
                        .frame(width: 100,height: 100)
                        .foregroundColor(Color.green)
                    Circle()
                        .frame(width: 100,height: 100)
                        .foregroundColor(Color.blue)
                }
            }
            Text("ZZZ")

        }
        //navigation또한 data에 의존한다.
//        .sheet(isPresented: $isPresented) {
//            TamagochiView()
//        }
        .fullScreenCover(isPresented: $isPresented) {
            TamagochiView()
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
