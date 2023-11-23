//
//  NavigationWrapper.swift
//  VersionControl
//
//  Created by Alex Cho on 11/23/23.
//

import SwiftUI

//private 불가, view 프로토콜 채택
//type parameter that conforms to view protocol
struct NavigationWrapper<Content: View>: View{
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View{
        
        if #available(iOS 16.0, *){
            NavigationStack{
                content
            }
        }else{
            NavigationView{
                content
            }
        }
    }
}
