//
//  ContentView.swift
//  VersionControl
//
//  Created by Alex Cho on 11/23/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        VStack {
            //조건 분기: 뷰 단위로 해야함
            if #available(iOS 15.0, *){
                Image(systemName: "globe")
                    .imageScale(.large)
                //iOS15+
                    .foregroundStyle(.red)
            }else{
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.red)
            }
            
            Image(systemName: "star")
                .foreground(.green) //분기처리 wrapper에서 대응
            
            Text("Hello, world!")
                .asPointBackgroundText()
            
            Text("Hello, world!")
                .asPointBackgroundText()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
