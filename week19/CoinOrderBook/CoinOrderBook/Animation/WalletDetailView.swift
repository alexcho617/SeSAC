//
//  WalletDetailView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/22.
//

import SwiftUI

struct WalletDetailView: View {
    
    @Binding var showDetail: Bool
    let cardDetail: CardModel
    var animation: Namespace.ID //.ID란 타입이 있나보다
    
    var body: some View {
        ZStack{
            Color(.gray.withAlphaComponent(0.5))
                .ignoresSafeArea()
            VStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(cardDetail.color)
                    .frame(height: 150)
                    .padding(.horizontal)
                    .onTapGesture {
                        showDetail = false
                    }
                    .matchedGeometryEffect(id: "ID", in: animation)
                Text(cardDetail.name)
                Spacer()
            }

        }
    }
}

//struct WalletDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WalletDetailView(showDetail: .constant(true), cardDetail: .constant(CardModel(name: "Card", index: 0)))
//    }
//}
