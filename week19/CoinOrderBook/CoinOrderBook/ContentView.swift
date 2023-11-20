//
//  ContentView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    @State private var balance = "111,111,111원"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    bannerVew()
                    LazyVStack {
                        ForEach(1..<50){ data in
                            ListView(data: data)
                        }
                    }
                }
                .padding()
            }
            .refreshable { //iOS15부터 이기 때문에 iOS13,14에선 UIKit의 pull to refresh 코드를 가져왔다.
                print("Refreshed")
                balance = "222,222,222원"
            }
            .navigationTitle("My Wallet")
        }
    }
    
    func bannerVew() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.blue)
                .frame(maxWidth: .infinity)
            .frame(height: 200)
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                Text(balance)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
    
    func ListView(data: Int) -> some View{
        
        HStack{
            VStack(alignment: .leading){
                Text("비트코인\(data)")
                Text("Bitcoin")
            }
            Spacer()
            Text("KRW - BTC")
        }
//        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        .padding(.vertical, 8)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
