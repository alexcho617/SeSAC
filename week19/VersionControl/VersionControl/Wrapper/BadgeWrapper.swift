//
//  BadgeWrapper.swift
//  VersionControl
//
//  Created by Alex Cho on 11/23/23.
//

import SwiftUI

private struct BadgeWrapper: ViewModifier{
    let badgeCount: Int
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *){
            content
                .badge(badgeCount)
        }else{
            content
        }
    }
    
}


extension View {
    func badges(_ count: Int) -> some View {
        modifier(BadgeWrapper(badgeCount: count))
    }
}
