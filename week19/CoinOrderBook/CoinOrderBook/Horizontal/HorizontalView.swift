//
//  HorizontalView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/27/23.
//

import SwiftUI

struct HorizontalView: View {
    
    @StateObject var viewModel = HorizontalViewModel()
    
    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                VStack {
                    Text("\(viewModel.value)")
                    ForEach(horizontalDummy) { dummy in
                        HStack {
                            Text(dummy.data)
                                .frame(width: proxy.size.width * 0.2)
                            ZStack(alignment: .leading){
                                Rectangle()
                                    .frame(width: CGFloat(dummy.point) / 20)
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(Color.blue.opacity(0.5))
                                Text("\(dummy.point)")
                            }
                            .frame(width: CGFloat(dummy.point) / 100)
                            .frame(maxWidth: proxy.size.width * 0.7)
                            .background(Color.gray)
                        }
                    }
                   
                }
                .background(Color.green)
                .onTapGesture {
                    print(proxy.size)
//                    viewModel.timer()
//                    print(horizontalDummy)
                    print(largest())
                }
            }
        }
    }
}

#Preview {
    HorizontalView()
}
