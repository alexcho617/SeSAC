//
//  CoinWidget.swift
//  CoinWidget
//
//  Created by Alex Cho on 11/29/23.
//

import WidgetKit
import SwiftUI

struct CoinWidget: Widget {
    //unique widget identifier
    static let kind: String = "CoinWidget"

    var body: some WidgetConfiguration { //3가지 컨피겨레이션이 있음
        //static 위젯
        StaticConfiguration(kind: CoinWidget.kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CoinWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget) //iOS17 modifier
            } else {
                CoinWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("최근 코인")
        .description("최근 검색한 코인 값을 확인하세여")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

//#Preview(as: .systemSmall) {
//    CoinWidget()
//} timeline: {
//    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
//}
