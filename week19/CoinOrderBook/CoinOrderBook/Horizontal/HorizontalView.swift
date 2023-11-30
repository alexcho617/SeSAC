//
//  HorizontalView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/27/23.
//

import SwiftUI
import WidgetKit
struct HorizontalView: View {
    //Default
    @StateObject var viewModel = HorizontalViewModel(market: Market(market: "krw-btc", korean_name: "비트코인", english_name: "Bitcoin"))
    
    var body: some View {
        ScrollView {
            Text("\(viewModel.market.market) - \(Int(viewModel.value))초")
            GeometryReader { proxy in
                let graphWidth = proxy.size.width * 0.7
                VStack {
                    Text("매수")
                    ForEach(viewModel.bidOrderbook, id: \.self) { item in
                        HStack {
                            Text("\(Int(item.price).formatted())원")
                                .frame(width: graphWidth * 0.4)
                            ZStack(alignment: .leading){
                                //최대값을 기준으로 상대적 길이 계산
                                let barSize = CGFloat(item.size) / viewModel.largestBidSize() * graphWidth
                                Rectangle()
                                    .frame(width: barSize)
                                    .frame(maxWidth: graphWidth, alignment: .leading)
                                .foregroundStyle(Color.red.opacity(0.5))
                                Text("\(item.size)")
                                    .frame(width: graphWidth)
                            }
                            .frame(maxWidth: graphWidth, alignment: .leading)
                        }
                    }
                    //
                    Text("매도")
                    ForEach(viewModel.askOrderbook, id: \.self) { item in
                        HStack {
                            Text("\(Int(item.price).formatted())원")
                                .frame(width: graphWidth * 0.4)
                            ZStack(alignment: .leading){
                                //최대값을 기준으로 상대적 길이 계산
                                let barSize = CGFloat(item.size) / viewModel.largestAskSize() * graphWidth
                                Rectangle()
                                    .frame(width: barSize)
                                    .frame(maxWidth: graphWidth, alignment: .leading)
                                .foregroundStyle(Color.blue.opacity(0.5))
                                Text("\(item.size)")
                                    .frame(width: graphWidth)
                            }
                            .frame(maxWidth: graphWidth, alignment: .leading)
                        }
                    }
                }
                
            }
        }.onAppear(perform: {
            viewModel.timer()
            //MARK: UserDefaults App Group
            print("APP Before", UserDefaults.groupShared.value(forKey: "Market"))
            print("APP Before", UserDefaults.groupShared.value(forKey: "Price"))

            UserDefaults.groupShared.set(viewModel.market.korean_name, forKey: "Market") //이렇게 되면 클릭한 상세 코인에 대해서 같은 키로 들어가게 됨, 따라서 조회한 제일 최근의 데이터가 들어가게 됨
            UserDefaults.groupShared.set(viewModel.largestAskSize() ?? 11111111, forKey: "Price") //이렇게 되면 클릭한 상세 코인에 대해서 같은 키로 들어가게 됨, 따라서 조회한 제일 최근의 데이터가 들어가게 됨

            print("APP After", UserDefaults.groupShared.value(forKey: "Market"))
            print("APP Before", UserDefaults.groupShared.value(forKey: "Price"))
            
            //위젯 갱신 요청, import widgetkit
//            WidgetCenter.shared.reloadAllTimelines()
            WidgetCenter.shared.reloadTimelines(ofKind: "CoinWidget") //CoinWidget.kind
            
            
        })
    }
}

#Preview {
    HorizontalView()
}
