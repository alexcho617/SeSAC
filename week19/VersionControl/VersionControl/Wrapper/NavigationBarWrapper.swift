//
//  NavigationBarWrapper.swift
//  VersionControl
//
//  Created by Alex Cho on 11/23/23.
//

import SwiftUI

struct NavigationBarWrapper<Leading: View, Trailing: View>: ViewModifier{
    
    let leading: Leading
    let trailing: Trailing
    
    init(@ViewBuilder leading: () -> Leading, @ViewBuilder trailing: () -> Trailing) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *){
            content
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        leading
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        trailing
                    }
                }
        }else{
            content
                .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
}

extension View{
    func navigationBar(
    @ViewBuilder leading: () -> some View,
    @ViewBuilder trailing: () -> some View) -> some View {
        modifier(NavigationBarWrapper(leading: leading, trailing: trailing))

    }
}
