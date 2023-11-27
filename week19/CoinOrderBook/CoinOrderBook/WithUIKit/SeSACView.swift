//
//  SeSACView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/27/23.
//

import SwiftUI

struct SeSACView: View {
    @State var textFieldText = "SwiftUI Text"
    @State var uiKitTextFieldText = "UIKIt Text"
    var body: some View {
        VStack(alignment: .center){
            Text(textFieldText)
            TextField("SwiftUI TextField", text: $textFieldText) //하위뷰에서 변경하기 때문에 binding 필요
            
            VStack{
                Text(uiKitTextFieldText)
                MyTextField(text: $uiKitTextFieldText)
            }.background(Color.gray)
            
            MyWebView(urlString: "https://www.naver.com")
                .frame(width: 300, height: 400)
        }
    }
}

#Preview {
    SeSACView()
}
