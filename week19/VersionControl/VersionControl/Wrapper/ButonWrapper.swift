//
//  ButonWrapper.swift
//  VersionControl
//
//  Created by Alex Cho on 11/23/23.
//

import SwiftUI

private struct ButtonWrapper: ViewModifier{
    var action: () -> Void
    
    func body(content: Content) -> some View {
        Button(action: action, label: {
            content
        })
        .buttonStyle(.plain)
        
    }
}

extension View{
    //여기에 왜 escaping이 들어강하는지 정화하게 모르겠음.
    func asButton(_ action: @escaping () -> Void) -> some View{
        modifier(ButtonWrapper(action: action))
    }
}
