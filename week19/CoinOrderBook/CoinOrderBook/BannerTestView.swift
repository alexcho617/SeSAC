//
//  BannerTestView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/21.
//

import SwiftUI

struct BannerTestView: View {
    @Binding var testNumber: Int
    var body: some View {
        VStack {
            Text("Banner TestView: \(testNumber)")
            Button("Update number") {
                testNumber = Int.random(in: 100...200)
            }
        }
    }
}

struct BannerTestView_Previews: PreviewProvider {
    static var previews: some View {
        BannerTestView(testNumber: .constant(-9))
    }
}
