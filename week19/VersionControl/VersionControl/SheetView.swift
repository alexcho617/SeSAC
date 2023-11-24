//
//  SheetView.swift
//  VersionControl
//
//  Created by Alex Cho on 11/24/23.
//

import SwiftUI

struct SheetView: View {
    @State private var showSheet = false
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).asButton {
                    print("HI")
                    showSheet = true
                }.background()
                
                ShareLink(item: URL(string: "https://www.apple.com")!)
            }
        }
        .sheet(isPresented: $showSheet, content: {
            ComponentView()
                .presentationDetents([.small, .medium, .large])
                .presentationDragIndicator(.visible)
        })
    }
}

extension PresentationDetent {
    static let small = Self.height(200)
}
#Preview {
    SheetView()
}
