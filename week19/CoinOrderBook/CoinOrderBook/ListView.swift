//
//  SwiftUIView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/21.
//

import SwiftUI

struct ListView: View {
    //리스트 뷰는 하위뷰임 따라서 상뷰가 다시 그려질 때 같이 인스탄스가 새로 생성됨
    // 유지안됨 
    @ObservedObject var viewModel = ListViewModel()
    
    //stateobject는 유지됨. 따라서 struct으로 하위뷰를 구성한다면 StateObject를 더 많이 사용함
//    @StateObject var viewModel = ListViewModel()
    
    var body: some View {
        LazyVStack {
            Button("Network Cal") {
                viewModel.fetchAllMarket()
            }
            ForEach(viewModel.market, id: \.self) { item in
                HStack {
                    VStack(alignment: .center) {
                        Text(item.korean_name)
                            .fontWeight(.black)
                        Text(item.english_name)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(item.market)
                }
                .padding()
            }
            .onAppear(){
                print("Listview: Appeared")
                //네트워크 과호출
//                viewModel.fetchAllMarket()
        }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
