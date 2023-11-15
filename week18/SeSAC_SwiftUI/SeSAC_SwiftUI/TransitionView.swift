//
//  TransitionView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/15.
//

import SwiftUI
/*
 버튼 클릭해서 화면 Dismiss/Pop
 데이터 전달
 */
struct TransitionView: View {
    @State private var isFull = false
    @State private var isSheet = false
    var body: some View {
        NavigationView {
            HStack(spacing: 20) {
                Button("Full") {
                    isFull.toggle()
                }
                Button("Sheet") {
                    isSheet.toggle()
                }
                NavigationLink("Push") {
                    RenderView()
                }
            }
            .sheet(isPresented: $isSheet) {
                RenderView()
            }
            .fullScreenCover(isPresented: $isFull) {
                RenderView()
        }
        }
    }
}

struct TransitionView_Previews: PreviewProvider {
    static var previews: some View {
        TransitionView()
    }
}
