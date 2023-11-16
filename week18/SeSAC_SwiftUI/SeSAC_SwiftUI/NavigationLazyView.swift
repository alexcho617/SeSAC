//
//  NavigationLazyView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/16.
//

import SwiftUI

struct LazyContainerView<T: View>: View {
    let buildView: () -> T
    
    init(_ buildView: @autoclosure @escaping () -> T) {
        self.buildView = buildView
    }
    
    var body: some View {
        buildView()
    }
}


