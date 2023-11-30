//
//  EntryView.swift
//  CoinWidgetExtension
//
//  Created by Alex Cho on 11/30/23.
//

import SwiftUI

//위젯을 구성하는 뷰
struct CoinWidgetEntryView : View {
    var entry: Provider.Entry
    
    //위젯 사이즈에 따라 safearea 설정해야함. iOS16은 패딩으로 했으나 17에선 SafeArea가 따로 생김.
    var body: some View {
        VStack {
            Text(entry.test)
            Text(entry.date, style: .time)
            Text(UserDefaults.groupShared.string(forKey: "Market") ?? "최근 마켓 없음")
            Text(UserDefaults.groupShared.string(forKey: "Price") ?? "최근 값 없음")
//            Text(entry.token)
//            Text(entry.price.formatted())
        }
    }
}
