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
    
    init(isFull: Bool = false, isSheet: Bool = false) {
        self.isFull = isFull
        self.isSheet = isSheet
        print("Transition Init")
    }
    
    var body: some View {
        NavigationView {
            HStack(spacing: 20) {
                Button("Full") {
                    isFull.toggle()
                }
                Button("Sheet") {
                    isSheet.toggle()
                }
                //Navigation Link도 미리 RenderView() init을 호출 하고있음
                //따라서 하위 뷰 init에 통신코드가 있다면 주의해야함
                NavigationLink("Push") {
//                    RenderView()
                    //컨테이너 뷰로 한번 더 감쌈
                    LazyContainerView(RenderView())
                }
                
                //문제 발생 점? 무조건 renderview만 띄우게되는데 다른 화면으 ㄹ띄우려면 또 다른 레이지 뷰를 만들면 되는데
                //레이지뷰의 Body를 Lazy parameter 로 주면 안되나?
                //이름만 전달해서 레이지뷰에서 switch로 반환하게 하면?
                //Generic으로 해결하면됨.
                NavigationLink("Another Push") {
                    LazyContainerView(SearchView())
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
