//
//  ComponentView.swift
//  VersionControl
//
//  Created by Alex Cho on 11/24/23.
//

import SwiftUI

struct ComponentView: View {
    var body: some View {
        let apple = ["iOS", "iPadOS", "watchOS", "visionOS"]
        @State var selectedIndex = 3
        
        //label 텍스트가 안나오는건 맥이나 워치에서 사용되는 코드
//        List {
            Section {
                Picker(selection: $selectedIndex){
                    ForEach(apple, id: \.self) { item in
                        Text(item)
                    }
                } label: {
                    Text("Apple")
                }.pickerStyle(.menu)
            }
            
            Section {
                Picker(selection: $selectedIndex){
                    ForEach(apple, id: \.self) { item in
                        Text(item)
                    }
                } label: {
                    Text("Apple")
                }.pickerStyle(.menu)
            }
//        }
    }
}

#Preview {
    ComponentView()
}
