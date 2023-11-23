//
//  MainNavigationView.swift
//  VersionControl
//
//  Created by Alex Cho on 11/23/23.
//

import SwiftUI

struct MainNavigationView: View {
    var sampleTest = false
    
    var body: some View {
        
        NavigationWrapper {
            Text("HI")
            sampleView
                .navigationTitle("Main")
                .navigationBar {
                    Image(systemName: "star")
                } trailing: {
                    Image(systemName: "circle")
                }

//                .navigationBarItems(
//                    leading: Text("Left"),
//                    trailing: EmptyView()
//                )
        }
        
    }
    
    @ViewBuilder //조건에 따라 다르게 보여줄 경우 필요하다. ios15기준 조건이 없는 경우 생략 가능
    var sampleView: some View{
        if sampleTest{
            Text("Sample True")
        }else{
            Text("Sample False")
        }
    }
}

#Preview {
    MainNavigationView()
}
